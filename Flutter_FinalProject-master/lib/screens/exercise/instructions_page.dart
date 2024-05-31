import 'package:crud/common_widget/RoundButton_Profile.dart';
import 'package:crud/common_widget/step_detail_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:crud/screens/Camera/Preview.dart';
import 'package:crud/screens/Camera/video.dart';
import '../../common/color_extension.dart';

class ExercisesStepDetails extends StatefulWidget {
  final Map eObj;
  const ExercisesStepDetails({super.key, required this.eObj});

  @override
  State<ExercisesStepDetails> createState() => _ExercisesStepDetailsState();
}

class _ExercisesStepDetailsState extends State<ExercisesStepDetails> {
  List stepArr = [
    {
      "no": "01",
      "title": "Hold the Dumbbells",
      "detail":
          "Start by holding a dumbbell in each hand, palms facing forward, and arms fully extended down by your sides."
    },
    {
      "no": "02",
      "title": "Curl the Weights",
      "detail":
          "Keeping your upper arms stationary, exhale as you curl the weights while contracting your biceps. Continue to raise the weights until your biceps are fully contracted and the dumbbells are at shoulder level."
    },
    {
      "no": "03",
      "title": "Lower the Weights",
      "detail":
          "Inhale as you slowly lower the dumbbells back to the starting position, fully extending your arms. Make sure to control the movement and avoid swinging the weights."
    },
    {
      "no": "04",
      "title": "Focus on Form",
      "detail":
          "Maintain proper form throughout the exercise, keeping your elbows close to your body and avoiding any momentum or cheating. Focus on feeling the contraction in your biceps with each repetition."
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/closed_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: media.width,
                        height: media.width * 0.43,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: TColor.primaryG),
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.asset(
                          "assets/img/Untitled design (1).png",
                          width: media.width,
                          height: media.width * 0.43,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        width: media.width,
                        height: media.width * 0.43,
                        decoration: BoxDecoration(
                            color: TColor.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      IconButton(
                        onPressed: () {
                          // Navigate to the camera screen upon button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen()),
                          );
                        },
                        icon: Hero(
                          tag:
                              'play_button_${widget.eObj["title"]}', // Unique tag based on title
                          child: Image.asset(
                            "assets/img/Play.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),

                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Image.asset(
                      //     "assets/img/Play.png",
                      //     width: 30,
                      //     height: 30,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.eObj["title"].toString(),
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Easy | 390 Calories Burn",
                    style: TextStyle(
                      color: TColor.gray,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Descriptions",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ReadMoreText(
                    'Did you know that the bicep curls hit 2 muscles of your arm called the biceps',
                    trimLines: 4,
                    colorClickableText: TColor.black,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Read More ...',
                    trimExpandedText: ' Read Less',
                    style: TextStyle(
                      color: TColor.gray,
                      fontSize: 12,
                    ),
                    moreStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "How To Do It",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "${stepArr.length} Sets",
                          style: TextStyle(color: TColor.gray, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: stepArr.length,
                    itemBuilder: ((context, index) {
                      var sObj = stepArr[index] as Map? ?? {};

                      return StepDetailRow(
                        sObj: sObj,
                        isLast: stepArr.last == sObj,
                      );
                    }),
                  ),
                  Text(
                    "Custom Repetitions",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 150,
                    child: CupertinoPicker.builder(
                      itemExtent: 40,
                      selectionOverlay: Container(
                        width: double.maxFinite,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: TColor.gray.withOpacity(0.2), width: 1),
                            bottom: BorderSide(
                                color: TColor.gray.withOpacity(0.2), width: 1),
                          ),
                        ),
                      ),
                      onSelectedItemChanged: (index) {},
                      childCount: 60,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/img/burn.png",
                              width: 15,
                              height: 15,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              " ${(index + 1) * 15} Calories Burn",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 10),
                            ),
                            Text(
                              " ${index + 1} ",
                              style: TextStyle(
                                  color: TColor.gray,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              " times",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 16),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: RoundButton(
                title: "Start Exercise",
                elevation: 0,
                onPressed: () {
                  // Navigate to the camera screen upon button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const YourCameraWidget()),
                  );
                }),
          ),
          // Positioned(
          //   left: 10,
          //   right: 10,
          //   bottom: 30,
          //   child: RoundButton(
          //       title: "Demo Video",
          //       elevation: 0,
          //       onPressed: () {
          //         // Navigate to the camera screen upon button press
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => VideoPlayerScreen()),
          //         );
          //       }),
          // ),
        ],
      ),
    );
  }
}
