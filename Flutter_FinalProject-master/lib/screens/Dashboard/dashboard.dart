import 'package:crud/bloc/bloc/firebase_user_bloc.dart';
import 'package:crud/bloc/bloc/firebase_user_event.dart';
import 'package:crud/bloc/bloc/firebase_user_state.dart';
import 'package:crud/common_widget/dashboard/Workoutrow.dart';
import 'package:crud/bloc/sign_in/sign_in_bloc.dart';
import 'package:crud/common/color_extension.dart';
import 'package:crud/common_widget/histogram.dart';

import 'package:crud/repo/firebaseUser.dart';


import 'package:crud/screens/Dashboard/notification_view.dart';
import 'package:crud/screens/Profile/profile_view.dart';
import 'package:crud/screens/exercise/exercise.dart';
import 'package:crud/screens/exercise/exercise_provider.dart';
import 'package:crud/screens/exercise/instructions_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  late final FirestoreService _firestoreService;
  String userName = "user";
  double userWeight = 20;
  double userHeight = 10;

  List lastWorkoutArr = [
    {
      "name": "Bicep Curls",
      "image": "assets/Workout1.png",
      "kcal": "180",
      "time": "20",
      "progress": 0.3,
      "next": {"title": "Bicep Curls"}
    },
    {
      "name": "Squats",
      "image": "assets/Workout2.png",
      "kcal": "200",
      "time": "30",
      "progress": 0.4,
      "next": {"title": "Squats"}
    },
    {
      "name": "Deadlift",
      "image": "assets/Workout3.png",
      "kcal": "300",
      "time": "40",
      "progress": 0.7,
      "next": {"title": "Deadlifts"}
    },
  ];

  @override
  void initState() {
    super.initState();

    _firestoreService = FirestoreService();

    BlocProvider.of<TodoBloc>(context)
        // .add(LoadUserByEmail(currentUser?.email ?? ''));
        .add(LoadTodos());
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.grey[300], // Set the app bar color
        bottomNavigationBar: BottomAppBar(
          height: 65,
          // color: Colors.white60,
          shape: const CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          ),
          // elevation: 50,
          toolbarHeight: 100,
          backgroundColor: TColor.backgrouncolor, // Set the app bar color
          automaticallyImplyLeading: false,
          // title:
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.notifications_active,
            //     size: 30,
            //   ),
            // ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationView(),
                    ),
                  );
                },
                icon: Image.asset(
                  "assets/img/notification_active.png",
                  width: 25,
                  height: 25,
                  fit: BoxFit.fitHeight,
                )),
            IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(const SignOutRequired());
              },
              icon: const Icon(
                Icons.logout_outlined,
                size: 30,
              ),
            )
          ],
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(
            backgroundColor: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  const SizedBox(height: 150),
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.black),
                    title: const Text("Home",
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Navigate to the Home screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info, color: Colors.black),
                    title: const Text("About",
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Navigate to the About screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.black),
                    title: const Text("Settings",
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle, color: Colors.black),
                    title: Text("View Profile",
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Navigate to the Home screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileView()),
                      );
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.account_circle, color: Colors.grey[400]),
                    title: Text("Bicep Curls",
                        style: TextStyle(color: Colors.blue[500])),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Navigate to the Home screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ExercisesStepDetails(eObj: {
                                  "title": "Bicep Curls",
                                })),
                      );
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.account_circle, color: Colors.grey[400]),
                    title: Text("Squats",
                        style: TextStyle(color: Colors.blue[500])),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Navigate to the Home screen
                      Navigator.push(
                        //check alignment sign up > profile else login > home page
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ExercisesStepDetails(eObj: {
                                  "title": "Squats",
                                })),
                      );
                    },
                  ),
                  ListTile(
                    leading:
                        Icon(Icons.account_circle, color: Colors.grey[400]),
                    title: Text("Deadlifts",
                        style: TextStyle(color: Colors.blue[500])),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Navigate to the Home screen
                      Navigator.pushReplacement(
                        //check alignment sign up > profile else login > home page
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ExercisesStepDetails(eObj: {
                                  "title": "Deadlifts",
                                })),
                      );
                    },
                  ),
                  const Spacer(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: const Text("Logout",
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state is TodoLoading) {
            // print("loading");

            // print(currentUser?.email);
            return const Center(child: CircularProgressIndicator());
            // return Container();
          } else if (state is TodoLoaded) {
            // print("Gello");
            // print(state.user.Name);

            //Mannual name from firebase
            final userStream =
                _firestoreService.getUserByEmail(currentUser?.email ?? '');
            userStream.listen((user) {
              userName = user.Name;
              // userWeight = user.Weight as double;
              // userHeight = user.Height as double;

              print(userName);
            });

            // setState(() {
            //     userName = user.Name; // Update the userName state variable
            //   });

            return SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Welcome Back,",
                                        style: TextStyle(
                                            // color: TColor.gray,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '${userName}',
                                        style: TextStyle(
                                            // color: TColor.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: media.width * 0.05),
                              Container(
                                height: media.width * 0.4,
                                decoration: BoxDecoration(
                                    gradient:
                                        LinearGradient(colors: TColor.primaryG),
                                    borderRadius: BorderRadius.circular(
                                        media.width * 0.075)),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/bg_dots.png",
                                      height: media.width * 0.4,
                                      width: double.maxFinite,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25, horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "BMI (Body Mass Index)",
                                                style: TextStyle(
                                                    color: TColor.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "You have a normal weight",
                                                style: TextStyle(
                                                    color: TColor.white
                                                        .withOpacity(0.7),
                                                    fontSize: 12),
                                              ),
                                              // OutlinedButton(
                                              //     onPressed: () {},
                                              //     style: OutlinedButton.styleFrom(
                                              //         backgroundColor: TColor.gray),
                                              //     child: Text("View more"))
                                            ],
                                          ),
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child: PieChart(
                                              PieChartData(
                                                pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (FlTouchEvent event,
                                                          pieTouchResponse) {},
                                                ),
                                                startDegreeOffset: 250,
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                sectionsSpace: 1,
                                                centerSpaceRadius: 0,
                                                sections: showingSections(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: media.width * 0.05,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: TColor.primaryColor2.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Today Target",
                                      style: TextStyle(
                                          color: TColor.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      width: 70,
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: media.width * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Workout",
                                    style: TextStyle(
                                        color: TColor.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ExerciseView()),
                                      );
                                    },
                                    child: Text(
                                      "See More",
                                      style: TextStyle(
                                          color: TColor.gray,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: media.width * 0.05,
                              ),

                              SizedBox(
                                height: media.width * 0.05,
                              ),
                              //histogram code
                              ChangeNotifierProvider(
                                create: (context) => ExerciseProvider(),
                                child: Histogram(),
                              ),
                              ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: lastWorkoutArr.length,
                                  itemBuilder: (context, index) {
                                    var wObj =
                                        lastWorkoutArr[index] as Map? ?? {};
                                    return InkWell(
                                        onTap: () {},
                                        child: WorkoutRow(wObj: wObj));
                                  }),
                            ]))));
          } else {
            return Container();
          }
        }));
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required color,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: color[100], borderRadius: BorderRadius.circular(12)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Icon(
              icon,
              size: 60,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 18),
            ),
            MaterialButton(
              onPressed: onPressed,
              color: color,
              child: const Text(
                "VIEW",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ]),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
      (i) {
        var color0 = TColor.secondaryColor1;

        switch (i) {
          case 0:
            return PieChartSectionData(
                color: color0,
                value: 33,
                title: '',
                radius: 55,
                titlePositionPercentageOffset: 0.55,
                badgeWidget: const Text(
                  "20,1",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ));
          case 1:
            return PieChartSectionData(
              color: Colors.white,
              value: 75,
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
            );

          default:
            throw Error();
        }
      },
    );
  }
}
