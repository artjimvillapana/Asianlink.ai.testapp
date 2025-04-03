import 'package:flutter/material.dart';
import 'package:test_login/components/buttons/custom_button.dart';

class SignUpButton extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;

  const SignUpButton({super.key, required this.controller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Determine if the input is active or not
    bool isActive = controller.text.isNotEmpty;

    return CustomButton(
      isActive: isActive, // Pass isActive state to CustomButton
      onPressed: isActive ? onPressed : () {}, // Provide an empty function when inactive
      text: 'Next',
      fontWeight: FontWeight.bold,
    );
  }
}
