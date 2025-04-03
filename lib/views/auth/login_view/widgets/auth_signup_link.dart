import 'package:flutter/material.dart';
import 'package:test_login/utils/colors/color.dart';
import 'package:test_login/views/auth/register_view/create_email/signup_create_email_view.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account yet? ",
          style: TextStyle(color: AppColors.fontSecondary, fontSize: 12),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: Text(
            " Sign up",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
