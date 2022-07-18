import 'package:flutter/material.dart';
import 'package:mileon/exerciseapi_model.dart';
import 'exercise_expanded.dart';
import 'string_helper.dart';

class ExerciseListView extends StatelessWidget {
  final List<ExerciseApiModel> exercises;
  final String bodyPart;
  const ExerciseListView({
    Key? key,
    required this.exercises,
    required this.bodyPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("${bodyPart.toTitleCase()} Exercises"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ExerciseExpandedView(
                              exercise: exercises[index],
                            ))));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                width: double.infinity,
                child: Row(
                  children: [
                    Hero(
                      tag: exercises[index],
                      child: Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          image: DecorationImage(
                            image: NetworkImage(exercises[index].gifUrl),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercises[index].name.toTitleCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Equipment: ${exercises[index].equipment.toTitleCase()}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 9, 45, 209),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
