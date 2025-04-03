import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_login/utils/helper/regex_valodator.dart';
import 'package:test_login/utils/helper/snackbar_service.dart';
import 'package:test_login/views/auth/otp_view/otp_view.dart';
import 'package:test_login/views/auth/register_view/create_email/widgets/signup_button.dart';
import 'package:test_login/views/auth/register_view/create_email/widgets/signup_header.dart';
import 'package:test_login/views/auth/register_view/create_email/widgets/signup_input.dart';
import 'package:test_login/views/auth/register_view/create_email/widgets/signup_prompt.dart';

class SignUpPasswordScreen extends ConsumerStatefulWidget {
  const SignUpPasswordScreen({super.key});

  @override
  SignUpPasswordScreenState createState() => SignUpPasswordScreenState();
}

class SignUpPasswordScreenState extends ConsumerState<SignUpPasswordScreen> {
  final TextEditingController inputController = TextEditingController();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    inputController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    inputController.removeListener(_onTextChanged);
    inputController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  void handleSignUp() {
    String input = inputController.text.trim();

    if (RegexValidator.isValidEmail(input) || RegexValidator.isValidPhoneNumber(input)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OtpScreen(isFor: "Sign up")),
      );
    } else {
      setState(() => errorMessage = "Enter a valid email or phone number");
      SnackbarService.showSnackbar(errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignUpHeader(),
              const SizedBox(height: 20),
              SignUpInputField(controller: inputController, errorMessage: errorMessage),
              const SizedBox(height: 20),
              SignUpButton(controller: inputController, onPressed: handleSignUp),
              const Spacer(),
              const SignUpSignInPrompt(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
