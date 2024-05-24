import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String id;
  final DateTime date;
  final int reps;

  Exercise({required this.id, required this.date, required this.reps});

  factory Exercise.fromMap(Map<String, dynamic> data, String id) {
    return Exercise(
      id: id,
      date: (data['date'] as Timestamp).toDate(),
      reps: data['reps'],
    );
  }
}
