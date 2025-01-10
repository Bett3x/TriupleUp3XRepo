import 'dart:async';
import 'package:flutter/material.dart';
import '../home/dashboard.dart'; // Import Dashboard screen

class OTPView extends StatefulWidget {
  const OTPView({super.key});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  // Controllers and FocusNodes for each input field
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  Color darkRed = const Color(0xFF9F201C);
  int _secondsRemaining = 60; // Countdown timer
  bool _isResendEnabled = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// Start Timer for Resend OTP
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        setState(() => _isResendEnabled = true);
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Gradient Background
    var gradient = SweepGradient(
      colors: [
        const Color.fromRGBO(221, 63, 53, 0.2),
        const Color.fromRGBO(221, 63, 53, 0.2),
        const Color.fromRGBO(221, 63, 53, 1),
        const Color.fromRGBO(221, 63, 53, 0.2),
      ],
      startAngle: 0.5,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent, // Transparent background
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: gradient), // Gradient overlay
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildOTPInfoText(),
              const SizedBox(height: 20),
              _buildOTPFields(),
              const SizedBox(height: 30),
              _buildBtn(context),
              const SizedBox(height: 15),
              _buildResendOption(),
            ],
          ),
        ),
      ),
    );
  }

  /// OTP Info Text
  Widget _buildOTPInfoText() {
    return Column(
      children: const [
        Text(
          'Please enter the OTP sent on',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          '+91 xxxxxxxxxx',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// OTP Input Fields with Auto-Focus
  Widget _buildOTPFields() {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
          color: Color(0xFFEB9D83)), // Input field border color
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(6, (index) {
          return SizedBox(
            width: 45,
            height: 50,
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center, // Horizontally centered
              textAlignVertical:
                  TextAlignVertical.center, // Vertically centered
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: const Color(0xFFEB9D83), // Background color
                errorBorder: border,
                focusedBorder: border,
                enabledBorder: border,
                disabledBorder: border,
              ),
              onChanged: (value) {
                // Move to next field if not empty
                if (value.isNotEmpty && index < 5) {
                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                }
                // Move to previous field on backspace
                else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                }
              },
            ),
          );
        }),
      ),
    );
  }

  /// Continue Button
  Widget _buildBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () => _validateAndSubmit(context),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(darkRed),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFE11616)),
            ),
          ),
          fixedSize: WidgetStatePropertyAll(
            Size(MediaQuery.of(context).size.width, 50),
          ),
        ),
        child: const Text('Continue', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  /// Resend OTP Option with Timer
  Widget _buildResendOption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text('Didn\'t receive OTP?',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          const SizedBox(height: 5),
          Text(
            _isResendEnabled
                ? 'Resend Now'
                : '00:${_secondsRemaining.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Validation Logic
  void _validateAndSubmit(BuildContext context) {
    String otp = _controllers.map((c) => c.text).join();

    if (otp == '000000' || otp == '111111' || otp == '222222') {
      // Navigate to Dashboard
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong OTP. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
