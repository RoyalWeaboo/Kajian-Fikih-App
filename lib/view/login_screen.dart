import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/dashboard_screen.dart';
import 'package:kajian_fikih/view/register_sceen.dart';
import 'package:kajian_fikih/view/ustadz/dashboard/ustadz_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          height: height,
          width: width,
          color: primaryColor,
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/main_logo.png",
                        width: 80,
                        height: 80,
                      ),
                      Text(
                        "Kajian Fikih",
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          color: whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet consectetur. Risus placerat dolor consectetur volutpat turpis. Hac adipiscing facilisis lacinia faucibus vitae enim lectus tristique. Egestas sit elit ac aliquam fringilla ac mattis bibendum. Ipsum mi nec sed felis mauris purus augue tincidunt. ",
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Form(
                        key: loginFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              validator: ((value) => validateEmail(value!)),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                              cursorColor: secondaryColor,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                hintText: "Email",
                                labelStyle: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w400),
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: whiteColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              validator: ((value) => validateEmail(value!)),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                              cursorColor: secondaryColor,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                hintText: "Password",
                                labelStyle: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w400),
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: whiteColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 4,
                                  top: 8,
                                ),
                                child: Text(
                                  "Lupa Password",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            CustomButton(
                              buttonText: "Masuk",
                              backgroundColor: secondaryColor,
                              borderRadius: 10,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  SlideLeftAnimation(
                                    page: const JamaahDashboardScreen(),
                                  ),
                                );
                              },
                              buttonTextColor: blackColor,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Tidak Memiliki Akun ? ",
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: whiteColor,
                                      ),
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            SlideLeftAnimation(
                                              page: const RegisterScreen(),
                                            ),
                                          );
                                        },
                                      text: "Daftar Disini",
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: height * 0.15,
                  child: Image.asset(
                    'assets/sharp_polygon.png',
                    width: 164,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: height * 0.16,
                    width: width,
                    color: whiteColor,
                    child: Column(
                      children: [
                        Text(
                          "Login with",
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              SlideLeftAnimation(
                                page: const UstadzDashboardScreen(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/google_login_button.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
