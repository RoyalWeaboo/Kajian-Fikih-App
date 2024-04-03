import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_top.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          SlideTopAnimation(
            page: const LoginScreen(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            width: width,
            color: primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/main_logo.png",
                  width: 120,
                  height: 120,
                ),
                Text(
                  "Kajian Fikih",
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    color: whiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: -32,
            child: Image.asset(
              "assets/rounded_polygon.png",
              width: 160,
            ),
          ),
        ],
      ),
    );
  }
}
