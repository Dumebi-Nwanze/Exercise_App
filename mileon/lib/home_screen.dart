import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mileon/cardio_exercise_model.dart';
import 'package:mileon/exercise_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExerciseModel> exercises = [];
  List<CardioExerciseModel> cardio = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    bottom: TabBar(tabs: [
                      Tab(
                        text: "Cardio",
                      ),
                      Tab(
                        text: "Strength/Calisthenics",
                      ),
                    ]),
                  ),
                  body: TabBarView(
                    children: [
                      buildCardioView(),
                      buildStrngthCalisView(),
                    ],
                  ),
                )),
          );
  }

  getExerciseList() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot snaphot = await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("cal-str_exercise")
        .orderBy(
          'timestamp',
          descending: true,
        )
        .get();
    setState(() {
      exercises =
          snaphot.docs.map((doc) => ExerciseModel.fromSnapsot(doc)).toList();
    });
  }

  getCardio() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snaphot = await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("car_exercise")
        .orderBy(
          'timestamp',
          descending: true,
        )
        .get();
    setState(() {
      cardio = snaphot.docs
          .map((doc) => CardioExerciseModel.fromSnapsot(doc))
          .toList();
    });
  }

  onLoad() async {
    await getExerciseList();
    await getCardio();
    setState(() {
      _isLoading = false;
    });
  }

  Widget buildCardioView() {
    return cardio.isEmpty
        ? Center(
            child: Text(
              'No exercises recorded',
            ),
          )
        : Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: ListView.builder(
                  itemCount: cardio.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          cardio[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        "${cardio[index].duration} minutes",
                      ),
                      trailing: Text(
                        "${cardio[index].distance} km",
                      ),
                    );
                  })),
            ),
          );
  }

  Widget buildStrngthCalisView() {
    return exercises.isEmpty
        ? Center(
            child: Text(
              'No exercises recorded',
            ),
          )
        : Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Text(
                        exercises[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        "${exercises[index].reps} reps",
                      ),
                      trailing: Text(
                        "${exercises[index].sets} sets",
                      ),
                    );
                  })),
            ),
          );
  }
}
