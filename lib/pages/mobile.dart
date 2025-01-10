import 'package:flutter/material.dart';
import 'auth_otp.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  bool checkBoxVal = false;
  Color darkRed = const Color(0xFF9F201C);
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: gradient),
      child: Center(
        child: Column(children: [
          const SizedBox(height: 30),
          _buildMobileField(),
          const SizedBox(height: 15),
          _buildOtpInfoText(),
          _buildTAndC(),
          const SizedBox(height: 15),
          _buildBtn(context), // Updated button to check validation
          _buildBottom(),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }

  /// Mobile Input Field
  Widget _buildMobileField() {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: darkRed),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mobile', style: TextStyle(color: Colors.white)),
          TextFormField(
            controller: _mobileController,
            maxLines: 1,
            keyboardType: TextInputType.number,
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

  /// OTP Info Text
  Widget _buildOtpInfoText() {
    return Text(
      'OTP will be sent to this number.',
      style: TextStyle(
        color: darkRed,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Terms and Conditions Checkbox
  Widget _buildTAndC() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceBetween,
        spacing: 5,
        children: [
          Checkbox(
            value: checkBoxVal,
            side: BorderSide(color: darkRed),
            fillColor: WidgetStatePropertyAll(darkRed),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (value) => setState(() => checkBoxVal = !checkBoxVal),
          ),
          const Text(
            'I certify that I am above 18 years, I agree to',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                'T&Cs.',
                style: TextStyle(
                  fontSize: 12,
                  decorationThickness: 1,
                  color: Colors.transparent,
                  decorationColor: Colors.white,
                  decoration: TextDecoration.underline,
                  shadows: [Shadow(color: Colors.white, offset: Offset(0, -1))],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Submit Button with Validation
  Widget _buildBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () => _validateAndNavigate(context), // Validation logic
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
        child: const Text('Send OTP', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  /// Bottom Links (Sign Up and Resend OTP)
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
                'Didn\'t receive OTP?',
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

  /// Validation and Navigation Logic
  void _validateAndNavigate(BuildContext context) {
    String mobile = _mobileController.text.trim();

    // Check if the mobile number is 10 digits
    if (mobile.length == 10 && RegExp(r'^[0-9]+$').hasMatch(mobile)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthOTP()),
      );
    } else {
      // Show error if invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit mobile number.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
