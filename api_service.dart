import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<dynamic> getPrediction(String input) async {
    final url = Uri.parse('$baseUrl/predict');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"input": input}),
    );

    if (response.statusCode == 200) {
      var prediction = jsonDecode(response.body)['prediction'];
      return prediction;
    } else {
      throw Exception('Failed to load prediction');
    }
  }
}
