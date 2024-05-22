import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../screens/exercise/exercise_provider.dart';

class Histogram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseProvider>(
      builder: (context, exerciseProvider, child) {
        if (exerciseProvider.exercises.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final barGroups = exerciseProvider.exercises.map((exercise) {
          return BarChartGroupData(
            x: exercise.date.day,
            barRods: [
              BarChartRodData(
                toY: exercise.reps.toDouble(),
                color: Colors.lightBlueAccent,
              ),
            ],
          );
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: barGroups,
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(
                  show: true,
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  bottomTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: true))),
            ),
          ),
        );
      },
    );
  }
}
