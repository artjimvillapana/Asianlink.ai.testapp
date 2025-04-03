import 'package:flutter/material.dart';
import 'package:test_login/components/buttons/custom_button.dart';
import 'package:test_login/utils/colors/color.dart';

class OtpButtons extends StatelessWidget {
  final TextEditingController otpController;
  final VoidCallback validateOtp;
  final int secondsRemaining;

  const OtpButtons({
    super.key,
    required this.otpController,
    required this.validateOtp,
    required this.secondsRemaining,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          isActive: otpController.text.length == 6,
          text: "Next",
          onPressed: validateOtp,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: secondsRemaining == 0
              ? () {
                  // Resend OTP logic here
                }
              : null,
          child: Text(
            "Resend code",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
