import 'package:flutter/material.dart';
import 'package:test_login/components/buttons/custom_button.dart';
import 'package:test_login/utils/colors/color.dart';

class CustomDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    String buttonText = "",
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: EdgeInsets.zero, // Remove default padding for the title
        title: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 8, // Adjust this value to fine-tune positioning
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.unSelectedColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
        content: Text(
          content,
          style: TextStyle(color: AppColors.fontSecondary, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          CustomButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            isActive: true,
            text: buttonText,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
    );
  }
}
