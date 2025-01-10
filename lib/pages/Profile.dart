import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
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
          // White Container with Input Fields and Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Section with Back Button
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Navigate back
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.red,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Update Profile",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        // Profile Picture with Camera Icon
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade300,
                              child: Icon(Icons.person,
                                  size: 30, color: Colors.red),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Input Fields with Labels
                    _buildLabeledTextField("User Name"),
                    _buildLabeledTextField("Name"),
                    _buildLabeledTextField("Email"),
                    _buildLabeledTextField("Mobile"),
                    _buildLabeledTextField("Change Password"),
                    _buildLabeledTextField("Gender"),
                    _buildLabeledTextField("Date of Birth"),
                    _buildLabeledTextField("City"),
                    Row(
                      children: [
                        Expanded(child: _buildLabeledTextField("State")),
                        SizedBox(width: 10),
                        Expanded(child: _buildLabeledTextField("Pin Code")),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        // Save Details Logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Squared edges
                        ),
                        shadowColor: Colors.black38,
                        elevation: 5, // Shadow around the button
                      ),
                      child: Text(
                        "Save Details",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
              'assets/images/logo.png', // Adjust the path to your logo
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Input Field Widget with Label
  Widget _buildLabeledTextField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5), // Small gap between label and input field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5), // Squared edges
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5), // Squared edges
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
