import 'package:flutter/material.dart';
import 'package:test_login/utils/colors/color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final double fontSize;
  final bool isError; // New property for error state

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.fontSize,
    this.isError = false, // Default to false
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    widget.controller.addListener(_updateActiveState);
  }

  void _updateActiveState() {
    setState(() {
      _isActive = widget.controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateActiveState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: widget.label,
            style: TextStyle(color: widget.isError ? Colors.red : Colors.black87),
            children: [
              TextSpan(
                text: " *",
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          child: TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: widget.isPassword ? _obscureText : false,
            style: TextStyle(fontSize: widget.fontSize),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 13, color: AppColors.unSelectedColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: widget.isError
                      ? Colors.red // Error state will show red border
                      : _isActive
                          ? AppColors.primary
                          : Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: widget.isError
                      ? Colors.red // Error state will show red border
                      : _isActive
                          ? AppColors.primary
                          : Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: widget.isError
                      ? Colors.red // Error state will show red border
                      : AppColors.primary,
                  width: 2,
                ),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off_outlined : Icons.visibility,
                        color: !_isActive ? AppColors.iconBlurry : Colors.black87,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
