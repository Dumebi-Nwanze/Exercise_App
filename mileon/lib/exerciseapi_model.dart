// To parse this JSON data, do
//
//     final exerciseApiModel = exerciseApiModelFromJson(jsonString);

import 'dart:convert';

List<ExerciseApiModel> exerciseApiModelFromJson(String str) =>
    List<ExerciseApiModel>.from(
        json.decode(str).map((x) => ExerciseApiModel.fromJson(x)));

String exerciseApiModelToJson(ExerciseApiModel data) =>
    json.encode(data.toJson());

class ExerciseApiModel {
  ExerciseApiModel({
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.id,
    required this.name,
    required this.target,
  });

  String bodyPart;
  String equipment;
  String gifUrl;
  String id;
  String name;
  String target;

  factory ExerciseApiModel.fromJson(Map<String, dynamic> json) =>
      ExerciseApiModel(
        bodyPart: json["bodyPart"],
        equipment: json["equipment"],
        gifUrl: json["gifUrl"],
        id: json["id"],
        name: json["name"],
        target: json["target"],
      );

  Map<String, dynamic> toJson() => {
        "bodyPart": bodyPart,
        "equipment": equipment,
        "gifUrl": gifUrl,
        "id": id,
        "name": name,
        "target": target,
      };
}
