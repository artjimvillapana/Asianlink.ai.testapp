import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:test_login/utils/colors/color.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isOtpIncorrect;

  const OtpInputField({super.key, required this.controller, required this.isOtpIncorrect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter OTP *",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isOtpIncorrect ? Colors.red : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Pinput(
          controller: controller,
          length: 6,
          defaultPinTheme: _pinTheme(isOtpIncorrect ? Colors.red : Colors.grey.shade400),
          focusedPinTheme: _pinTheme(isOtpIncorrect ? Colors.red : AppColors.primary),
          submittedPinTheme: _pinTheme(isOtpIncorrect ? Colors.red : AppColors.primary),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  PinTheme _pinTheme(Color borderColor) {
    return PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
