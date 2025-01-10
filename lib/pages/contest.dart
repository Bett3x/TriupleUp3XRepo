import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';
import 'fetch.dart';

class ContestPage extends StatefulWidget {
  @override
  _ContestPageState createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  int timeRemaining = 20; // Initial time for the timer
  Timer? _timer;
  final List<double> _scaleFactor = [1.0, 1.0, 1.0, 1.0];
  int _selectedOption = -1;
  int _currentQuestionIndex = 0;
  late Future<List<Map<String, dynamic>>> _questions;
  bool _isBuffering = false; // To show/hide the buffering overlay
  bool _isResultShowing = false; // To block interaction during result display

  @override
  void initState() {
    super.initState();
    startTimer();
    _questions =
        FirebaseService().fetchQuestions(); // Fetch questions on page load
  }

  void startTimer() {
    timeRemaining = 20;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        timer.cancel();
        _handleTimeUp();
      }
    });
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  void _handleTimeUp() {
    stopTimer();
    setState(() {
      _isBuffering = true; // Lock the UI for automatic navigation
    });

    // Automatically go to the next question after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isBuffering = false;
        _goToNextQuestion();
      });
    });
  }

  void _onOptionClick(int index) {
    if (_isBuffering || _isResultShowing)
      return; // Prevent interactions during loading or results

    setState(() {
      _scaleFactor[index] = 1.2;
      _selectedOption = index;
    });

    Vibration.vibrate(duration: 50);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _scaleFactor[index] = 1.0;
        });
      }
    });
  }

  Future<void> _onSubmit(List<Map<String, dynamic>> questions) async {
    if (_selectedOption == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an option before submitting!'),
        ),
      );
      return;
    }

    setState(() {
      _isBuffering = true; // Show the buffering overlay
    });

    stopTimer(); // Stop the timer when submitting

    final question = questions[_currentQuestionIndex];
    try {
      await FirebaseService().incrementCounter(
          questionKey: question['key'], optionIndex: _selectedOption);

      final updatedOptions =
          await FirebaseService().fetchUpdatedOptions(question['key']);

      final maxCount = updatedOptions.fold<int>(
        0,
        (prev, option) => option['counter'] > prev ? option['counter'] : prev,
      );
      final correctOptions = updatedOptions
          .where((option) => option['counter'] == maxCount)
          .toList();

      setState(() {
        _isBuffering = false; // Hide the buffering overlay
        _isResultShowing = true; // Block user interaction during result display
      });

      _showResultDialog(correctOptions, question['options']);
    } catch (e) {
      setState(() {
        _isBuffering = false; // Hide the buffering overlay
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void _showResultDialog(List<Map<String, dynamic>> correctOptions,
      List<Map<String, dynamic>> options) {
    final isCorrect = _selectedOption != -1 &&
        correctOptions.any((correctOption) =>
            correctOption['option'] == options[_selectedOption]['option']);

    final resultText =
        isCorrect ? "Result Will be Shown Later" : "Result Will be Shown Later";

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal of the result dialog
      builder: (context) => AlertDialog(
        title: const Text('Result'),
        content: Text(resultText),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context); // Close the dialog
        setState(() {
          _isResultShowing = false; // Allow interactions after result display
          _goToNextQuestion();
        });
      }
    });
  }

  void _goToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < 4) {
        _currentQuestionIndex++;
        _selectedOption = -1;
        timeRemaining = 20;
        startTimer(); // Restart the timer for the next question
      } else {
        stopTimer(); // Ensure the timer stops when quiz is completed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quiz Completed!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.black,
                          iconSize: 30.0,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF5E8E7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          '${timeRemaining}s',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: _questions,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No questions available.'),
                            );
                          } else {
                            final questions = snapshot.data!;
                            final question = questions[_currentQuestionIndex];
                            final options = question['options'];

                            return Column(
                              children: [
                                Text(
                                  question['question'],
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24.0),
                                for (var i = 0; i < options.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: GestureDetector(
                                      onTap: () => _onOptionClick(i),
                                      child: AnimatedScale(
                                        scale: _scaleFactor[i],
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: _selectedOption == i
                                                ? const Color(0xFF9CDFE7)
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0, 2),
                                                blurRadius: 4.0,
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 12.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${[
                                                  'A.',
                                                  'B.',
                                                  'C.',
                                                  'D.'
                                                ][i]} ',
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  options[i]['option'],
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () => _onSubmit(questions),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8B0000),
                                  ),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isBuffering || _isResultShowing)
            Stack(
              children: [
                ModalBarrier(
                  color: Colors.black54,
                  dismissible: false,
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
