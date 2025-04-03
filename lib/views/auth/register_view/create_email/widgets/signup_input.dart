import 'package:flutter/material.dart';
import 'package:test_login/components/textfields/custom_textfield.dart';

class SignUpInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorMessage;

  const SignUpInputField({super.key, required this.controller, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: "Mobile number or Email",
      hintText: "Enter your email or phone number",
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      fontSize: 12,
      isError: errorMessage != null,
    );
  }
}
