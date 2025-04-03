import 'package:flutter/material.dart';
import 'package:test_login/utils/colors/color.dart';

class OtpTimer extends StatelessWidget {
  final int secondsRemaining;

  const OtpTimer({super.key, required this.secondsRemaining});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Code is expiring in ",
        style: const TextStyle(color: Colors.grey, fontSize: 12),
        children: [
          TextSpan(
            text: "$secondsRemaining seconds",
            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
