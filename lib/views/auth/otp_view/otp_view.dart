import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_login/controller/providers/auth_provider.dart';
import 'package:test_login/utils/helper/snackbar_service.dart';
import 'package:test_login/views/auth/otp_view/widgets/otp_buttons.dart';
import 'package:test_login/views/auth/otp_view/widgets/otp_head.dart';
import 'package:test_login/views/auth/otp_view/widgets/otp_input.dart';
import 'package:test_login/views/auth/otp_view/widgets/otp_timer.dart';
import 'package:test_login/views/auth/register_view/create_password/signup_create_password_view.dart';
import 'package:test_login/views/home/home_view.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String isFor;

  const OtpScreen({super.key, required this.isFor});

  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  int secondsRemaining = 300;
  bool isOtpIncorrect = false;

  @override
  void initState() {
    super.initState();
    ref.read(authProvider.notifier).generateOtp();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && secondsRemaining > 0) {
        setState(() => secondsRemaining--);
        _startTimer();
      }
    });
  }

  void validateOtp() {
    final authNotifier = ref.read(authProvider.notifier);
    setState(() => isOtpIncorrect = !authNotifier.validateOtp(otpController.text));

    if (!isOtpIncorrect) {
      if (widget.isFor == "Sign up") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePasswordScreen()));
        SnackbarService.showSnackbar("OTP Verified Successfully!");
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
        SnackbarService.showSnackbar("OTP Verified Successfully!");
      }
    } else {
      SnackbarService.showSnackbar("Invalid OTP, please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const OtpHeader(),
              const SizedBox(height: 20),
              OtpInputField(controller: otpController, isOtpIncorrect: isOtpIncorrect),
              const SizedBox(height: 20),
              OtpTimer(secondsRemaining: secondsRemaining),
              const SizedBox(height: 20),
              OtpButtons(
                otpController: otpController,
                validateOtp: validateOtp,
                secondsRemaining: secondsRemaining,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
