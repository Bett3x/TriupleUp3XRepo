import 'package:flutter/material.dart';

class WrongPage extends StatelessWidget {
  final String question;
  final VoidCallback onNext;

  const WrongPage({required this.question, required this.onNext, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Automatically trigger the onNext function after 2 seconds
    Future.delayed(const Duration(seconds: 2), onNext);

    return Scaffold(
      backgroundColor:
          Colors.red.withOpacity(0.6), // Transparent red background
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.close,
                  size: 80,
                  color: Colors.white, // Cross icon
                ),
                const SizedBox(height: 20),
                Text(
                  "BETTER LUCK NEXT TIME!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
