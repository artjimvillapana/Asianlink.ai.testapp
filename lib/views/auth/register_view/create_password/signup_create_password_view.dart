import 'package:flutter/material.dart';
import 'package:test_login/components/buttons/custom_button.dart';
import 'package:test_login/components/terms-condition/terms_condition_checkbox.dart';
import 'package:test_login/views/auth/login_view/widgets/auth_signup_link.dart';
import 'package:test_login/views/auth/register_view/create_password/widgets/signup_password_criteria.dart';
import 'package:test_login/views/auth/register_view/create_password/widgets/signup_password_input.dart';
import 'package:test_login/views/home/home_view.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  CreatePasswordScreenState createState() => CreatePasswordScreenState();
}

class CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordChanged);
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    setState(() {
      _isPasswordValid = validatePassword(_passwordController.text);
    });
  }

  bool validatePassword(String password) {
    return password.length >= 8 && RegExp(r"[A-Z]").hasMatch(password) && RegExp(r"[0-9]").hasMatch(password) && RegExp(r"[!@#\$%&-]").hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              PasswordInput(controller: _passwordController),
              const SizedBox(height: 10),
              PasswordValidation(password: _passwordController.text),
              const SizedBox(height: 20),
              CustomButton(
                isActive: _isPasswordValid,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                text: 'Sign up',
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              const TermsAndConditionsCheckbox(),
              const Spacer(),
              AuthFooter(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
