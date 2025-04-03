import 'package:flutter/material.dart';
import 'package:test_login/utils/colors/color.dart';
import 'package:test_login/views/auth/login_view/auth_screen.dart';

class SignUpSignInPrompt extends StatelessWidget {
  const SignUpSignInPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?", style: TextStyle(color: AppColors.fontSecondary)),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AuthScreen()),
          ),
          child: Text(
            "Sign in",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
