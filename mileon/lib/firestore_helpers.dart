import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mileon/cardio_exercise_model.dart';
import 'package:mileon/exercise_model.dart';

recordExercise({required ExerciseModel exerciseModel}) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore
      .collection("users")
      .doc(auth.currentUser!.uid)
      .collection("cal-str_exercise")
      .doc()
      .set(exerciseModel.toJson());
}

recordCardio({required CardioExerciseModel cardioExerciseModel}) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore
      .collection("users")
      .doc(auth.currentUser!.uid)
      .collection("car_exercise")
      .doc()
      .set(cardioExerciseModel.toJson());
}
