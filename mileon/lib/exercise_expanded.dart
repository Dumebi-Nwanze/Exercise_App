import 'package:flutter/material.dart';
import 'string_helper.dart';
import 'package:mileon/exerciseapi_model.dart';

class ExerciseExpandedView extends StatelessWidget {
  final ExerciseApiModel exercise;
  const ExerciseExpandedView({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          exercise.name.toTitleCase(),
        ),
      ),
      body: ListView(
        children: [
          Hero(
              tag: exercise,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  exercise.gifUrl,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              exercise.name.toTitleCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              "Required Equipment",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 32.0),
            child: Text(
              exercise.equipment.toTitleCase(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
