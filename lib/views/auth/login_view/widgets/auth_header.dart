import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Login",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );
  }
}
