import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Sign up",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }
}
