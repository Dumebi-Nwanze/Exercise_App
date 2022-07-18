import 'package:cloud_firestore/cloud_firestore.dart';

class CardioExerciseModel {
  final String name;
  final String duration;
  final String distance;
  final DateTime timestamp;

  CardioExerciseModel({
    required this.name,
    required this.duration,
    required this.distance,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "duration": duration,
      "distance": distance,
      "timestamp": timestamp
    };
  }

  static CardioExerciseModel fromSnapsot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return CardioExerciseModel(
      name: snap['name'],
      duration: snap['duration'],
      distance: snap['distance'],
      timestamp: snap['timestamp'].toDate(),
    );
  }
}
