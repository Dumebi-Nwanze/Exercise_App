import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mileon/exerciseapi_model.dart';

class ExerciseAPI {
  static const String _url = "https://exercisedb.p.rapidapi.com/exercises";
  static const Map<String, String> _headers = {
    'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
    'X-RapidAPI-Key': 'API-KEY'
  };

  Future<List<ExerciseApiModel>?> fetchExercises() async {
    var client = http.Client();
    Uri uri = Uri.parse(_url);
    final response = await client.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      String json = response.body.toString();
      return exerciseApiModelFromJson(json);
    }
    return [];
  }
}
