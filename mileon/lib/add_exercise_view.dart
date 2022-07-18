import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mileon/exercise_model.dart';
import 'package:mileon/firestore_helpers.dart';
import 'package:numberpicker/numberpicker.dart';

import 'cardio_exercise_model.dart';

class AddExercise extends StatefulWidget {
  AddExercise({Key? key}) : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final _formKey = GlobalKey<FormState>();
  final _calformKey = GlobalKey<FormState>();
  final _carformKey = GlobalKey<FormState>();
  TextEditingController _exerciseController = TextEditingController();

  TextEditingController _setsController = TextEditingController();
  TextEditingController _repsController = TextEditingController();

  TextEditingController _calexerciseController = TextEditingController();

  TextEditingController _calsetsController = TextEditingController();
  TextEditingController _calrepsController = TextEditingController();

  TextEditingController _carexerciseController = TextEditingController();

  TextEditingController _carDurationController = TextEditingController();
  TextEditingController _carDistanceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(tabs: [
                Tab(
                  text: "Cardio",
                ),
                Tab(
                  text: "Strength Training",
                ),
                Tab(
                  text: "Calisthenics",
                ),
              ]),
            ),
            body: TabBarView(
              children: [
                buildCardioTrainView(context),
                buildStrengthTrainView(context),
                buildCalithenicsTrainView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStrengthTrainView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Add Exercise",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _exerciseController,
                  onSaved: (value) {
                    _exerciseController.text = value!;
                  },
                  validator: (value) {
                    if (value == "") return "Please fill this out";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter exercise name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _setsController,
                  onSaved: (value) {
                    _setsController.text = value!;
                  },
                  validator: (value) {
                    if (value == "") return "Please fill this out";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter set amount",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _repsController,
                  onSaved: (value) {
                    _repsController.text = value!;
                  },
                  validator: (value) {
                    if (value == "") return "Please fill this out";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter reps amount",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  ExerciseModel exerciseModel = ExerciseModel(
                      name: _exerciseController.text,
                      sets: _setsController.text,
                      reps: _repsController.text,
                      timestamp: DateTime.now());
                  await recordExercise(exerciseModel: exerciseModel);
                  _exerciseController.clear();
                  _setsController.clear();
                  _repsController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 2.0,
                    )),
                child: Center(
                    child: Text(
                  "Record Exercise",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      )),
    );
  }

  Widget buildCalithenicsTrainView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Add Exercise",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Form(
            key: _calformKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _calexerciseController,
                  onSaved: (value) {
                    _calexerciseController.text = value!;
                  },
                  validator: (value) {
                    if (value == "") return "Please fill this out";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter exercise name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _calsetsController,
                  onSaved: (value) {
                    _calsetsController.text = value!;
                  },
                  validator: (value) {
                    if (value == "") return "Please fill this out";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter set amount",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _calrepsController,
                  onSaved: (value) {
                    _calrepsController.text = value!;
                  },
                  validator: (value) {
                    if (value == "") return "Please fill this out";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter reps amount",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                if (_calformKey.currentState!.validate()) {
                  ExerciseModel exerciseModel = ExerciseModel(
                    name: _calexerciseController.text,
                    sets: _calsetsController.text,
                    reps: _calrepsController.text,
                    timestamp: DateTime.now(),
                  );
                  await recordExercise(exerciseModel: exerciseModel);
                  _calexerciseController.clear();
                  _calsetsController.clear();
                  _calrepsController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 2.0,
                    )),
                child: Center(
                    child: Text(
                  "Record Exercise",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      )),
    );
  }

  Widget buildCardioTrainView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Add Exercise",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Form(
            key: _carformKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _carexerciseController,
                  onSaved: (value) {
                    _carexerciseController.text = value!;
                  },
                  validator: (value) {
                    if (value == "") return "Please fill this out";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter exercise name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _carDurationController,
                  onSaved: (value) {
                    _carDurationController.text = value!;
                  },
                  validator: (value) {
                    if (value == "") return "Please fill this out";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter duration in minutes",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _carDistanceController,
                  onSaved: (value) {
                    _carDistanceController.text = value!;
                  },
                  validator: (value) {
                    if (value == "") return "Please fill this out";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter distance in km",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                if (_carformKey.currentState!.validate()) {
                  CardioExerciseModel cardioExerciseModel = CardioExerciseModel(
                    name: _carexerciseController.text,
                    duration: _carDurationController.text,
                    distance: _carDistanceController.text,
                    timestamp: DateTime.now(),
                  );
                  await recordCardio(cardioExerciseModel: cardioExerciseModel);
                  _carexerciseController.clear();
                  _carDurationController.clear();
                  _carDistanceController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 2.0,
                    )),
                child: Center(
                    child: Text(
                  "Record Exercise",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      )),
    );
  }
}
