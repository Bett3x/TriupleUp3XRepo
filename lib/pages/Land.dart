// lib/pages/land.dart

import 'package:flutter/material.dart';

import 'auth_main.dart';

class LandPage extends StatefulWidget {
  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to LoginPage after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              AuthMain(), // Ensure LoginPage is defined in login.dart
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background.png'), // Background Image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered Logo, white line, and semi-transparent box with text
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              // Logo Image with responsive width and height
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: screenWidth * 0.5, // 50% of the screen width
                  height: screenHeight * 0.15, // 15% of the screen height
                  fit: BoxFit
                      .contain, // Ensures the image maintains its aspect ratio
                ),
              ),
              SizedBox(height: 10), // Space between logo and line
              // White line below the logo
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        screenWidth * 0.1), // 10% padding from each side
                child: Container(
                  height: 2.0, // Line height
                  color: Colors.white, // Line color
                ),
              ),
              SizedBox(height: 20), // Space between line and box
            ],
          ),
          // Semi-transparent box with rounded corners and text positioned above the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: 40.0), // Position above the bottom of the page
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                    0.4), // Very transparent color for a slight touch
                borderRadius: BorderRadius.circular(12.0), // Curved edges
              ),
              child: Text(
                "Let's get started",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF9D2011), // Text color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
