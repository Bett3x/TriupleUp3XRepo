import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http; // HTTP client for making requests

class FirebaseService {
  final String databaseUrl =
      "https://contestpage-30638-default-rtdb.firebaseio.com/";

  Future<void> uploadQuestion({
    required String question,
    required List<Map<String, dynamic>> options,
  }) async {
    final url = Uri.parse(
        '$databaseUrl/questions.json'); // URL endpoint for "questions"

    // Create the question data
    final Map<String, dynamic> questionData = {
      "question": question,
      "options": options,
    };

    try {
      // Make a POST request to add the question
      final response = await http.post(
        url,
        body: json.encode(questionData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Question uploaded successfully!');
        print('Response: ${response.body}');
      } else {
        print('Failed to upload question. Status Code: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error uploading question: $e');
    }
  }
}

void main() async {
  final firebaseService = FirebaseService();

  // Example question data
  final String questionText = "What is the capital of France?";
  final List<Map<String, dynamic>> options = [
    {"option": "Paris", "counter": 0},
    {"option": "London", "counter": 0},
    {"option": "Berlin", "counter": 0},
    {"option": "Rome", "counter": 0},
  ];

  // Upload the question
  print("Uploading question...");
  await firebaseService.uploadQuestion(
      question: questionText, options: options);
}
