import 'dart:convert';
import 'package:http/http.dart' as http;
import 'diabetes_model.dart';

class ApiService {
  static const String _baseUrl =
      "https://AyobBleblo-Diabetes-predictor.hf.space/predict";

  Future<String> predict(DiabetesInput input) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(input.toJson()),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // The API returns {'prediction': 2.0}
      final prediction = body['prediction'];

      if (prediction == 0.0 || prediction == 0) {
        return "No Diabetes";
      } else if (prediction == 1.0 || prediction == 1) {
        return "Pre-diabetes";
      } else if (prediction == 2.0 || prediction == 2) {
        return "Diabetes";
      } else {
        return "Unknown: $prediction";
      }
    } else {
      throw Exception('Failed to load prediction: ${response.statusCode}');
    }
  }
}
