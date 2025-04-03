import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_login/controller/providers/auth_provider.dart';
import 'package:test_login/utils/colors/color.dart';

class TermsAndConditionsCheckbox extends ConsumerWidget {
  const TermsAndConditionsCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTermsAccepted = ref.watch(termsAcceptedProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns checkbox with text
      spacing: 5,
      children: [
        Checkbox(
          value: isTermsAccepted,
          onChanged: (value) {
            ref.read(termsAcceptedProvider.notifier).state = value ?? false;
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10), // Aligns text with checkbox
            child: Text.rich(
              TextSpan(
                text: "I have read and agree to the ",
                style: const TextStyle(color: AppColors.fontSecondary, fontSize: 12),
                children: [
                  _buildLink("Terms of Use", () {}),
                  const TextSpan(text: ", "),
                  _buildLink("Privacy Policy", () {}),
                  const TextSpan(text: ", "),
                  _buildLink("Community Guidelines", () {}),
                  const TextSpan(text: ", and "),
                  _buildLink("Cookie Policy", () {}),
                  const TextSpan(text: "."),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  TextSpan _buildLink(String text, VoidCallback onTap) {
    return TextSpan(
      text: text,
      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w200, fontSize: 12),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}
