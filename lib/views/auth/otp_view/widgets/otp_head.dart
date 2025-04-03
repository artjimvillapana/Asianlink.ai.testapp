import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  const OtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Please check your email or message inbox for the OTP. If you don't see it, check your spam or junk folder.",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}
