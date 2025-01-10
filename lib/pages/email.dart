import 'package:flutter/material.dart';
import '../home/dashboard.dart'; // Import Dashboard screen
import 'auth_main.dart';

class EmailView extends StatefulWidget {
  const EmailView({super.key});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  Color darkRed = const Color(0xFF9F201C);

  // Controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Gradient background
    var gradient = SweepGradient(
      colors: [
        kTabActiveBgColor.withOpacity(.2),
        kTabActiveBgColor.withOpacity(.2),
        kTabActiveBgColor.withOpacity(1),
        kTabActiveBgColor.withOpacity(.2),
      ],
      startAngle: 0.5,
    );
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Center(
        child: Column(children: [
          const SizedBox(height: 30),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 30),
          _buildBtn(context), // Submit button with validation
          _buildBottom(),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }

  /// Email Input Field
  Widget _buildEmailField() {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: darkRed));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Email Address', style: TextStyle(color: Colors.white)),
          TextFormField(
            controller: _emailController,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              filled: true,
              errorBorder: border,
              focusedBorder: border,
              enabledBorder: border,
              disabledBorder: border,
              focusedErrorBorder: border,
              fillColor: Colors.white.withOpacity(.3),
            ),
          ),
        ],
      ),
    );
  }

  /// Password Input Field
  Widget _buildPasswordField() {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: darkRed));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Password', style: TextStyle(color: Colors.white)),
          TextFormField(
            controller: _passwordController,
            maxLines: 1,
            obscureText: true, // Hide password text
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              filled: true,
              errorBorder: border,
              focusedBorder: border,
              enabledBorder: border,
              disabledBorder: border,
              focusedErrorBorder: border,
              fillColor: Colors.white.withOpacity(.3),
            ),
          ),
        ],
      ),
    );
  }

  /// Login Button with Validation
  Widget _buildBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
          onPressed: () => _validateAndLogin(context), // Validation logic
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(darkRed),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFE11616)))),
              fixedSize: WidgetStatePropertyAll(
                  Size(MediaQuery.of(context).size.width, 50))),
          child: const Text('LOGIN', style: TextStyle(color: Colors.white))),
    );
  }

  /// Bottom Links (Sign Up and Forgot Password)
  Widget _buildBottom() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 16,
                  decorationThickness: 1,
                  color: Colors.transparent,
                  decorationColor: Colors.white,
                  decoration: TextDecoration.underline,
                  shadows: [Shadow(color: Colors.white, offset: Offset(0, -1))],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 16,
                  decorationThickness: 1,
                  color: Colors.transparent,
                  decorationColor: Colors.white,
                  decoration: TextDecoration.underline,
                  shadows: [Shadow(color: Colors.white, offset: Offset(0, -1))],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Validation and Login Logic
  void _validateAndLogin(BuildContext context) {
    // Fetch input values
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Check if fields are not empty
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All fields are required.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Check email and password match
    if (email == 'admin@google.com' && password == 'admin123') {
      // Navigate to Dashboard
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
