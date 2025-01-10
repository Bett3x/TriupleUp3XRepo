import 'package:flutter/material.dart';

class ReferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // White Container with Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    // Title and Subtitle
                    Text(
                      "Refer friends & earn",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Rs. xx",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Refer Image
                    Image.asset(
                      'assets/icons/Refer.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 20),
                    // Referral Code and Share Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Referral Code Box
                        Expanded(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () {
                              // Copy referral code logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Referral code copied!"),
                                ),
                              );
                            },
                            child: Container(
                              height: 55, // Match the height of the share box
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Your referral code",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "XXXXXX",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // Share Button
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              // Share logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Share button clicked!"),
                                ),
                              );
                            },
                            child: Container(
                              height:
                                  55, // Same height as the referral code box
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.share,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Steps
                    _buildStep(1, "Send an invite to a friend."),
                    _buildStep(2, "Your friend signs up."),
                    _buildStep(3,
                        "You'll both get rewards when your friend deposits for the 1st time."),
                  ],
                ),
              ),
            ),
          ),
          // Logo Positioned at the Top Center
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 50, // Center the logo
            child: Image.asset(
              'assets/images/logo.png',
              width: 100,
              height: 100,
            ),
          ),
          // Back Button
          Positioned(
            top: 50,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int stepNumber, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.red.shade100,
            child: Text(
              stepNumber.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
