import 'package:flutter/material.dart';
import 'package:test_login/utils/colors/color.dart';

class PasswordValidation extends StatelessWidget {
  final String password;

  const PasswordValidation({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildValidationIndicator("Minimum length: 8 characters", password.length >= 8),
        _buildValidationIndicator("1 uppercase letter", RegExp(r"[A-Z]").hasMatch(password)),
        _buildValidationIndicator("Alphanumeric", RegExp(r"[0-9]").hasMatch(password)),
        _buildValidationIndicator("Accepted special characters: ! @ # \$ % & -", RegExp(r"[!@#\$%&-]").hasMatch(password)),
      ],
    );
  }

  Widget _buildValidationIndicator(String text, bool isValid) {
    return Row(
      spacing: 5,
      children: [
        Icon(Icons.check, color: isValid ? AppColors.primary : AppColors.unSelectedColor, size: 16),
        const SizedBox(width: 5),
        Text(text, style: TextStyle(color: isValid ? AppColors.primary : AppColors.fontSecondary, fontSize: 12)),
      ],
    );
  }
}
