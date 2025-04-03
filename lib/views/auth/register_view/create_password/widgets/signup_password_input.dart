import 'package:flutter/material.dart';
import 'package:test_login/components/textfields/custom_textfield.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: "Password",
      hintText: "Enter your password",
      isPassword: true,
      textInputAction: TextInputAction.done,
      fontSize: 15,
    );
  }
}
