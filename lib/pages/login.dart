import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool checkBoxVal = false;

  // Color Constants
  final Color containerColor =
      const Color(0xFFDD6F4A).withOpacity(0.6); // Transparent container
  final Color whiteTextColor = Colors.white;
  final Color inputFieldColor = const Color(0xFFE19482);
  final Color inputBorderColor = const Color(0xFFC73D1E);
  final Color orLineColor = const Color(0xFF9F2413);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // Logo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 70,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Back Button and "Sign Up"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: whiteTextColor, // Changed to white
                            fontSize: 20, // Reduced size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Curved Container (stretched to edges)
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width, // Full width
                    decoration: BoxDecoration(
                      color: containerColor, // Transparent color
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Input Fields
                        _buildInputField("Mobile Number"),
                        const SizedBox(height: 15),
                        _buildInputField("Email Address"),
                        const SizedBox(height: 15),
                        _buildInputField("Password", obscureText: true),
                        const SizedBox(height: 15),
                        _buildInputField("Confirm Password", obscureText: true),
                        const SizedBox(height: 20),

                        // Terms & Conditions
                        Row(
                          children: [
                            Checkbox(
                              value: checkBoxVal,
                              activeColor: inputBorderColor,
                              onChanged: (value) {
                                setState(() => checkBoxVal = !checkBoxVal);
                              },
                            ),
                            Expanded(
                              child: Text(
                                "I certify that I am above 18 years, I agree to T&Cs.",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Create Account Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: inputBorderColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Button logic
                            },
                            child: const Text(
                              "CREATE ACCOUNT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // OR Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: orLineColor,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: orLineColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: orLineColor,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Social Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Image.asset(
                                "assets/icons/google.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                            const SizedBox(width: 20),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Image.asset(
                                "assets/icons/facebook.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Already Signed In
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Already have an account? Sign In",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Input Field Widget
  Widget _buildInputField(String label, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: inputFieldColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: inputBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: inputBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
