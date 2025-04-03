import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_login/components/buttons/custom_button.dart';
import 'package:test_login/components/terms-condition/terms_condition_checkbox.dart';
import 'package:test_login/components/textfields/custom_textfield.dart';
import 'package:test_login/controller/providers/auth_provider.dart';
import 'package:test_login/utils/colors/color.dart';
import 'package:test_login/views/auth/otp_view/otp_view.dart';

class AuthForm extends ConsumerStatefulWidget {
  const AuthForm({super.key});

  @override
  AuthFormState createState() => AuthFormState();
}

class AuthFormState extends ConsumerState<AuthForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool iserror = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateInput);
    _passwordController.addListener(_validateInput);
  }

  void _validateInput() {
    setState(() {});
  }

  void _attemptLogin(BuildContext context, WidgetRef ref, String email, String password) {
    final authNotifier = ref.read(authProvider.notifier);
    final result = authNotifier.login(email, password, context);

    if (result != null) {
      setState(() {
        iserror = true;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpScreen(isFor: "Login")));
      setState(() {
        iserror = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: _emailController,
          label: "Mobile number or Email",
          hintText: "Enter your email or phone number",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          fontSize: 12,
          isError: iserror,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _passwordController,
          label: "Password",
          hintText: "Enter your password",
          isPassword: true,
          textInputAction: TextInputAction.done,
          fontSize: 15,
          isError: iserror,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              "Forgot password?",
              style: TextStyle(
                color: AppColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Consumer(builder: (context, ref, _) {
          return CustomButton(
            isActive: ref.watch(termsAcceptedProvider),
            text: "Login",
            fontWeight: FontWeight.bold,
            onPressed: () {
              final email = _emailController.text.trim();
              final password = _passwordController.text.trim();
              _attemptLogin(context, ref, email, password);
            },
          );
        }),
        const SizedBox(height: 10),
        const TermsAndConditionsCheckbox(),
      ],
    );
  }
}
