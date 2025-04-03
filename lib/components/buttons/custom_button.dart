import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_login/utils/colors/color.dart';

class CustomButton extends ConsumerWidget {
  final bool isActive;
  final String text;
  final VoidCallback onPressed;
  final FontWeight fontWeight;

  const CustomButton({super.key, required this.isActive, required this.text, required this.onPressed, required this.fontWeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: isActive ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [Colors.blue, AppColors.primary], // Blue on left, Primary on right
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : const LinearGradient(
                  colors: [AppColors.bluelight, AppColors.bluelight], // Disabled state
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
