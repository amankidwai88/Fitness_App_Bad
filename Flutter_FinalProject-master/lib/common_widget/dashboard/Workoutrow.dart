import 'package:crud/common/color_extension.dart';
import 'package:crud/screens/exercise/instructions_page.dart';
import 'package:flutter/material.dart';

class WorkoutRow extends StatelessWidget {
  final Map wObj;
  const WorkoutRow({super.key, required this.wObj});

  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                wObj["image"].toString(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wObj["name"].toString(),
                  style: TextStyle(color: TColor.black, fontSize: 12),
                ),
                Text(
                  "${wObj["kcal"].toString()} Calories Burn | ${wObj["time"].toString()}minutes",
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExercisesStepDetails(
                        eObj: wObj['next'],
                      ),
                    ),
                  );
                },
                icon: Image.asset(
                  "assets/next_icon.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ))
          ],
        ));
  }
}
