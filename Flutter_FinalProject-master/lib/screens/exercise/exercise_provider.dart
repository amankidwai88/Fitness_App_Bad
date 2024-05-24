// providers/exercise_provider.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/exercise_model.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = [];

  List<Exercise> get exercises => _exercises;

  ExerciseProvider() {
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.email;
    final snapshot = await FirebaseFirestore.instance
        .collection("FirebaseUser")
        .doc(userId)
        .collection('exercises')
        .get();
    _exercises = snapshot.docs
        .map((doc) => Exercise.fromMap(doc.data(), doc.id))
        .toList();
    notifyListeners();
  }
}

// class ExerciseProvider with ChangeNotifier {
//   List<Exercise> _exercises = [];

//   List<Exercise> get exercises => _exercises;

//   ExerciseProvider() {
//     fetchExercises();
//   }

//   Future<void> fetchExercises() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser == null) {
//       return;
//     }

//     final userId = currentUser.email;

//     final snapshot = await FirebaseFirestore.instance
//         .collection('exercises')
//         .where('id', isEqualTo: userId)
//         .get();

//     _exercises = snapshot.docs
//         .map((doc) => Exercise.fromMap(doc.data(), doc.id))
//         .toList();
//     notifyListeners();
//   }
// }
