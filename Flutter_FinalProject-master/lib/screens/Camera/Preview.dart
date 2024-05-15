import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;


class YourCameraWidget extends StatefulWidget {
  const YourCameraWidget({Key? key}) : super(key: key);

  @override
  _YourCameraWidgetState createState() => _YourCameraWidgetState();
}

class _YourCameraWidgetState extends State<YourCameraWidget> {
  late CameraController controller;
  late List<CameraDescription> cameras;
  late tfl.Interpreter interpreter;
  List<List<List<double>>> outputData = [];
  bool _isMounted = false;
  bool _showEdges = true; // Flag to toggle showing edges
  double inferenceTime = 0;
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;
  Duration _totalElapsedTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    loadModel();
    _startTimer();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(
      cameras[0],
      ResolutionPreset.high, // Adjust resolution preset to high
    );
    await controller.initialize();
    controller.setFlashMode(FlashMode.off);
    setState(() {
      _isMounted = true;
    });
    captureAndProcessImageContinuously();
  }

  Future<void> loadModel() async {
    var interpreterOptions = tfl.InterpreterOptions()..addDelegate(tfl.XNNPackDelegate());

    interpreter = await tfl.Interpreter.fromAsset('assets/movenet_singlepose_lightning_v3.tflite', options: interpreterOptions);
    interpreter.allocateTensors();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += Duration(seconds: 1);
        _totalElapsedTime += Duration(seconds: 1);
      });
    });
  }

  void _toggleTimer() {
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
      } else {
        _startTimer();
      }
    }
  }

  Future<void> captureAndProcessImageContinuously() async {
    while (_isMounted) {
      await captureAndProcessImage();
      await Future.delayed(const Duration(microseconds: 10));
    }
  }

  Future<void> captureAndProcessImage() async {
    try {
      XFile imageFile = await controller.takePicture();
      Uint8List bytes = await imageFile.readAsBytes();
      img.Image originalImage = img.decodeImage(bytes)!;
      img.Image resizedImage = img.copyResize(originalImage, width: 192, height: 192);

      List<List<List<num>>> imageMatrix = List.generate(
        resizedImage.height,
            (y) => List.generate(
          resizedImage.width,
              (x) => [
            resizedImage.getPixel(x, y).r.toDouble(),
            resizedImage.getPixel(x, y).g.toDouble(),
            resizedImage.getPixel(x, y).b.toDouble(),
          ],
        ),
      );

      final input = [imageMatrix];
      List<List<List<List<double>>>> output = List.filled(1, List.filled(1, List.filled(17, List.filled(3, 0.0))));

      final startTime = DateTime.now();
      interpreter.run(input, output);
      final endTime = DateTime.now();
      final inferenceTimeMs = endTime.difference(startTime).inMilliseconds.toDouble();

      setState(() {
        outputData = output.first;
        inferenceTime = inferenceTimeMs;
      });
    } catch (e) {}
  }

  bool _frontCamera = false;

  Future<void> _toggleCamera() async {
    // Stop continuous capture process
    _isMounted = false;

    await controller.dispose();
    _frontCamera = !_frontCamera;
    controller = CameraController(
      _frontCamera ? cameras[1] : cameras[0],
      ResolutionPreset.high, // Adjust resolution preset to high
    );
    await controller.initialize();
    setState(() {});

    // Restart continuous capture process
    _isMounted = true;
    captureAndProcessImageContinuously();
  }

  void _toggleEdgesVisibility() {
    setState(() {
      _showEdges = !_showEdges;
    });
  }

  @override
  void dispose() {
    _isMounted = false;
    controller.dispose();
    interpreter.close();
    _timer?.cancel(); // Cancel timer when disposing
    super.dispose();
  }

  String formatElapsedTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isMounted
          ? Stack(
        children: [
          Transform.scale(
            scale: 1 / (controller.value.aspectRatio * MediaQuery.of(context).size.aspectRatio),
            alignment: Alignment.topCenter,
            child: ClipRect(
              clipper: _MediaSizeClipper(MediaQuery.of(context).size),
              child: CameraPreview(controller),
            ),
          ),
          if (_showEdges) // Only draw keypoints if showEdges is true
            CustomPaint(
              painter: KeypointsPainter(
                keypoints: outputData,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * controller.value.aspectRatio,
                context: context,
              ),
              willChange: true,
            ),
          Positioned(
            top: 40.0,
            right: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Time: ${formatElapsedTime(_elapsedTime)}',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          : const CircularProgressIndicator(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 50.0, right: 16.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Your back is not straight!',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      onPressed: _toggleEdgesVisibility,
                      backgroundColor: Colors.lightBlue,
                      child: _showEdges ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                    ),
                    FloatingActionButton(
                      onPressed: _toggleCamera,
                      backgroundColor: Colors.lightBlue,
                      child: const Icon(Icons.switch_camera),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;

  const _MediaSizeClipper(this.mediaSize);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class KeypointsPainter extends CustomPainter {
  final List<List<List<double>>> keypoints;
  final double width;
  final double height;
  final BuildContext context;

  KeypointsPainter({
    required this.keypoints,
    required this.width,
    required this.height,
    required this.context, // Add context parameter
  });

  final List<List<int>> EDGES = [
    // [0, 1],
    // [0, 2],
    //  [1, 3],
    //  [2, 4],
    //  [0, 5],
    //  [0, 6],
    [5, 7],
    [7, 9],
    [6, 8],
    [8, 10],
    [5, 6],
    [5, 11],
    [6, 12],
    [11, 12],
    [11, 13],
    [13, 15],
    [12, 14],
    [14, 16],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (keypoints.isEmpty) {
      return;
    }
    Paint pointPaint = Paint()..color = Colors.green;
    Paint linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;

    for (var edge in EDGES) {
      int i = edge[0];
      int j = edge[1];
      double confidence1 = keypoints[0][i][2];
      double confidence2 = keypoints[0][j][2];

      if (confidence1 > 0.2 && confidence2 > 0.2) {
        connectKeypoints(canvas, i, j, linePaint, pointPaint);
      }
    }
  }

  void connectKeypoints(
      Canvas canvas, int i, int j, Paint paint, Paint pointPaint) {
    double x1 = keypoints[0][i][1] * width;
    double y1 = keypoints[0][i][0] * height;
    double x2 = keypoints[0][j][1] * width;
    double y2 = keypoints[0][j][0] * height;

    // Scale coordinates to match the new preview size
    x1 *= MediaQuery.of(context).size.width / width;
    y1 *= MediaQuery.of(context).size.height / height;
    x2 *= MediaQuery.of(context).size.width / width;
    y2 *= MediaQuery.of(context).size.height / height;

    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    canvas.drawCircle(Offset(x1, y1), 3, pointPaint);
    canvas.drawCircle(Offset(x2, y2), 3, pointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}