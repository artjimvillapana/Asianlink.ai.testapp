import 'package:flutter/material.dart';
import 'package:test_login/components/buttons/social_button.dart';

class AuthSocial extends StatelessWidget {
  const AuthSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialLoginButton(
          text: "Continue with Google",
          iconPath: 'assets/icons/google-icon.png',
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        SocialLoginButton(
          text: "Continue with Facebook",
          iconPath: 'assets/icons/facebook-icon.png',
          onPressed: () {},
        ),
      ],
    );
  }
}
