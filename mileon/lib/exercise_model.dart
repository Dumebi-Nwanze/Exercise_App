import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseModel {
  final String name;
  final String reps;
  final String sets;
  final DateTime timestamp;

  ExerciseModel({
    required this.name,
    required this.sets,
    required this.reps,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "sets": sets,
      "reps": reps,
      "timestamp": timestamp,
    };
  }

  static ExerciseModel fromSnapsot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return ExerciseModel(
      name: snap['name'],
      sets: snap['sets'],
      reps: snap['reps'],
      timestamp: snap['timestamp'].toDate(),
    );
  }
}
