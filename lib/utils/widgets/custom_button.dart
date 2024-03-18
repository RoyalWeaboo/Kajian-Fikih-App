import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color buttonTextColor;
  final double? borderRadius;
  final Function() onPressed;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.backgroundColor,
    required this.onPressed,
    required this.buttonTextColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.outfit(
              color: buttonTextColor,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
