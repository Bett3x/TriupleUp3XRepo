import 'package:flutter/material.dart';

class CheckPage extends StatelessWidget {
  final String selectedAnswer;
  final String correctAnswer;
  final Map<String, dynamic> nextQuestion;

  CheckPage({
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.nextQuestion,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the outcome
    bool isCorrect = selectedAnswer == correctAnswer;

    // Show the pop-up message
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context, nextQuestion); // Return to ContestPage
    });

    return Scaffold(
      backgroundColor: isCorrect ? Colors.green : Colors.red,
      body: Center(
        child: Text(
          isCorrect ? 'Correct!' : 'Wrong!',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
