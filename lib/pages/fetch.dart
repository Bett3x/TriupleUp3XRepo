import 'dart:convert'; // For decoding the JSON data
import 'dart:math'; // For shuffling
import 'package:http/http.dart' as http; // HTTP client for making requests

class FirebaseService {
  final String databaseUrl = "https://triupleup3x-default-rtdb.firebaseio.com/";

  /// Fetch 7 random questions from Firebase
  Future<List<Map<String, dynamic>>> fetchQuestions() async {
    final url = Uri.parse('$databaseUrl/questions.json');

    try {
      // Make the GET request
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);

        // Return an empty list if no data is available
        if (data.isEmpty) {
          return [];
        }

        // Convert JSON data into a List of questions
        List<Map<String, dynamic>> questions = [];
        data.forEach((key, value) {
          questions.add({
            "key": key, // Firebase ID of the question
            "question": value["question"],
            "options": List<Map<String, dynamic>>.from(value["options"]),
          });
        });

        // Shuffle questions for randomness
        questions.shuffle(Random());

        // Return only the first 7 questions
        return questions.take(7).toList();
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }

  /// Increment the counter for the selected option
  Future<void> incrementCounter({
    required String questionKey,
    required int optionIndex,
  }) async {
    final url = Uri.parse(
        '$databaseUrl/questions/$questionKey/options/$optionIndex/counter.json');
    print("Incrementing counter at: $url");

    try {
      // Fetch the current counter value
      final getResponse = await http.get(url);
      print("GET response: ${getResponse.body}");

      if (getResponse.statusCode == 200) {
        final currentCounter = json.decode(getResponse.body) ?? 0;
        print("Current counter: $currentCounter");

        // Increment the counter
        final newCounter = currentCounter + 1;

        // Update the counter
        final patchResponse = await http.put(
          url,
          body: json.encode(newCounter),
          headers: {'Content-Type': 'application/json'},
        );
        print("PATCH response: ${patchResponse.body}");

        if (patchResponse.statusCode != 200) {
          throw Exception('Failed to update counter');
        }
      } else {
        throw Exception('Failed to fetch current counter value');
      }
    } catch (e) {
      print("Error incrementing counter: $e");
      throw e;
    }
  }

  /// Fetch updated options for a specific question
  Future<List<Map<String, dynamic>>> fetchUpdatedOptions(
      String questionKey) async {
    final url = Uri.parse('$databaseUrl/questions/$questionKey/options.json');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> optionsData = json.decode(response.body);
        print("Fetched updated options: $optionsData");

        // Parse the options into a list of maps
        return optionsData
            .asMap()
            .entries
            .map((entry) => {
                  "index":
                      entry.key, // Include the index for further operations
                  "option": entry.value["option"],
                  "counter": entry.value["counter"] ?? 0,
                })
            .toList();
      } else {
        throw Exception('Failed to fetch updated options');
      }
    } catch (e) {
      print("Error fetching updated options: $e");
      throw Exception('Error fetching updated options: $e');
    }
  }

  /// Upload a question with options to Firebase
  Future<void> uploadQuestion({
    required String question,
    required List<Map<String, dynamic>> options,
  }) async {
    final url = Uri.parse('$databaseUrl/questions.json');

    final Map<String, dynamic> questionData = {
      "question": question,
      "options": options,
    };

    try {
      final response = await http.post(
        url,
        body: json.encode(questionData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Question uploaded successfully!');
      } else {
        print('Failed to upload question. Status Code: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error uploading question: $e');
    }
  }
}
