import 'package:flutter/material.dart';
import 'package:test_login/utils/colors/color.dart';

class ValidationIndicator extends StatelessWidget {
  final String text;
  final bool isValid;

  const ValidationIndicator(this.text, this.isValid, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check, color: isValid ? AppColors.primary : AppColors.unSelectedColor, size: 16),
        const SizedBox(width: 5),
        Text(text, style: TextStyle(color: isValid ? AppColors.primary : AppColors.fontSecondary, fontSize: 12)),
      ],
    );
  }
}
