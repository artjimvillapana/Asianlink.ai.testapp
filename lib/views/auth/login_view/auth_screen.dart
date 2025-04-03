import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_login/views/auth/login_view/widgets/auth_form.dart';
import 'package:test_login/views/auth/login_view/widgets/auth_header.dart';
import 'package:test_login/views/auth/login_view/widgets/auth_signup_link.dart';
import 'package:test_login/views/auth/login_view/widgets/auth_social_buttons.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const AuthHeader(),
              const SizedBox(height: 20),
              AuthForm(),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const AuthFooter(),
              const SizedBox(height: 20),
              const AuthSocial(),
            ],
          ),
        ),
      ),
    );
  }
}
