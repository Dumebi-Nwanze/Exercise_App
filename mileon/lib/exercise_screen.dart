import 'package:flutter/material.dart';
import 'package:mileon/add_exercise_view.dart';
import 'package:mileon/exercise_api.dart';
import 'package:mileon/exercise_list.dart';
import 'string_helper.dart';
import 'package:mileon/exerciseapi_model.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<ExerciseApiModel>? exercises;
  bool _isLoaded = false;
  var bodyParts = [
    "Choose a body part",
    "back",
    "cardio",
    "chest",
    "lower arms",
    "lower legs",
    "neck",
    "shoulders",
    "upper arms",
    "upper legs",
    "waist",
  ];
  String dropdownvalue = "Choose a body part";
  List<ExerciseApiModel> results = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    exercises = await ExerciseAPI().fetchExercises();
    if (exercises != []) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddExercise(),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Visibility(
              visible: _isLoaded,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search for exercises by body parts",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    width: double.infinity,
                    height: 45,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownvalue = value!;
                          });
                        },
                        value: dropdownvalue,
                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                        isExpanded: true,
                        items: bodyParts.map((parts) {
                          return DropdownMenuItem(
                            child: Text(parts.toTitleCase()),
                            value: parts,
                          );
                        }).toList(),
                        focusColor: Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (dropdownvalue != "Choose a body part") {
                          setState(() {
                            results = exercises!.where((exercise) {
                              return exercise.bodyPart == dropdownvalue;
                            }).toList();
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ExerciseListView(
                                        exercises: results,
                                        bodyPart: dropdownvalue,
                                      ))));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 2.0,
                            )),
                        child: Center(
                            child: Text(
                          "SEARCH EXERCISE",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
