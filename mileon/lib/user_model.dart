import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  final String uid;
  final String name;
  final String email;
  final String birthday;
  final String weight;
  final String height;
  final String bmi;
  final String averagebloodpressure;

  Usermodel({
    required this.uid,
    required this.name,
    required this.email,
    required this.birthday,
    this.weight = "",
    this.height = "",
    this.bmi = "",
    this.averagebloodpressure = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "birthday": birthday,
      "weight": weight,
      "height": height,
      "bmi": bmi,
      "averagebloodpressure": averagebloodpressure,
    };
  }

  static Usermodel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Usermodel(
      uid: snap['uid'],
      name: snap['name'],
      email: snap['email'],
      birthday: snap['birthday'],
      weight: snap['weight'],
      height: snap['height'],
      bmi: snap['bmi'],
      averagebloodpressure: snap['averagebloodpressure'],
    );
  }
}
