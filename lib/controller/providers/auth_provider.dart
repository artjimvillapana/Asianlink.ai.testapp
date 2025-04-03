import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_login/components/custom_dialog/custom_dialog.dart';
import 'package:test_login/utils/app_constant/app_constant.dart';
import 'package:test_login/utils/helper/regex_valodator.dart';

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier(this.ref) : super(false);
  final Ref ref;
  int failedAttempts = 0;
  String? generatedOtp;

  String? login(String input, String password, BuildContext context) {
    if (input.trim().isEmpty || password.trim().isEmpty) {
      return "Email/Phone and password cannot be empty";
    }

    failedAttempts++;
    if (failedAttempts >= 5) {
      CustomDialog.show(
        context: context,
        title: "Account Locked",
        content: "Please try logging in again after 10 minutes, or reset your password.",
        buttonText: "Forgot Password",
      );
      Future.delayed(const Duration(seconds: 10), () => failedAttempts = 0);
      return "Too many failed attempts. Account locked.";
    }

    bool isEmail = RegexValidator.isValidEmail(input);
    bool isPhone = !isEmail && RegexValidator.isValidPhoneNumber(input);

    if (!isEmail && !isPhone) {
      return "Invalid email or phone number format";
    }

    if (!RegexValidator.isValidPassword(password)) {
      ref.read(termsAcceptedProvider.notifier).state = false;
      return "Password must be at least 6 characters";
    }

    final String normalizedInput = input.trim().toLowerCase();
    final String storedEmail = AppConstant.email.toLowerCase();
    final String storedPhone = AppConstant.phone.trim();
    final String storedPassword = AppConstant.password.trim();

    if ((normalizedInput == storedEmail || input.trim() == storedPhone) && password.trim() == storedPassword) {
      generateOtp();
      return null;
    }

    return "Incorrect email, phone number, or password";
  }

  void generateOtp() {
    generatedOtp = AppConstant.otp;
  }

  bool validateOtp(String inputOtp) {
    if (generatedOtp == null) {
      print("Error: OTP has not been generated!");
      return false;
    }
    print("Generated OTP: $generatedOtp, Entered OTP: $inputOtp"); // Debugging log
    return inputOtp.trim() == generatedOtp!.trim();
  }

  String? signUp(String input, String password) {
    if (input.isEmpty || password.isEmpty) {
      return "Email/Phone and password cannot be empty";
    }

    bool isEmail = RegexValidator.isValidEmail(input);
    bool isPhone = !isEmail && RegexValidator.isValidPhoneNumber(input);

    if (!isEmail && !isPhone) {
      return "Invalid email or phone number format";
    }

    if (!RegexValidator.isValidPassword(password)) {
      return "Password must be at least 6 characters";
    }

    state = true;
    return null;
  }

  void logout() => state = false;
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) => AuthNotifier(ref));
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
