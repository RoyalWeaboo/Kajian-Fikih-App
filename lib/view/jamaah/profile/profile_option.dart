import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';

class ProfileItemOption extends StatelessWidget {
  final String optionIcon;
  final String optionName;
  const ProfileItemOption(
      {super.key, required this.optionIcon, required this.optionName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            children: [
              Image.asset(
                optionIcon,
                width: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                optionName,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: blackTextColor,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
