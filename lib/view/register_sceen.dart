import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final loginFormKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool agreement = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        height: height,
        width: width,
        color: primaryColor,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
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
                  "Lorem ipsum dolor sit amet consectetur. Risus placerat dolor consectetur volutpat turpis. Hac adipiscing facilisis lacinia faucibus vitae enim lectus tristique.",
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
                        controller: _usernameController,
                        validator: ((value) => validateUsername(value!)),
                        keyboardType: TextInputType.text,
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
                          hintText: "Username",
                          labelStyle: GoogleFonts.outfit(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w400),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        controller: _phoneController,
                        validator: ((value) => validatePhoneNumber(value!)),
                        keyboardType: TextInputType.phone,
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
                          hintText: "Nomor Telepon",
                          labelStyle: GoogleFonts.outfit(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w400),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        controller: _emailController,
                        validator: ((value) => validateEmail(value!)),
                        keyboardType: TextInputType.text,
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        controller: _confirmPasswordController,
                        validator: ((value) => validateConfirmPassword(
                              value!,
                              _passwordController.text,
                            )),
                        keyboardType: TextInputType.text,
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
                          hintText: "Konfirmasi Password",
                          labelStyle: GoogleFonts.outfit(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w400),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        validator: ((value) => validatePassword(value!)),
                        keyboardType: TextInputType.text,
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                      Row(
                        children: [
                          Checkbox(
                            value: agreement,
                            side: const BorderSide(color: outlineColor),
                            checkColor: blackColor,
                            activeColor: secondaryColor,
                            onChanged: (value) {
                              setState(() {
                                agreement = !agreement;
                              });
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Saya setuju dengan ",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: whiteColor,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //link persyaratan
                                    },
                                  text: "Persyaratan",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: " dan ",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: whiteColor,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //link privasi
                                    },
                                  text: "Privasi",
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        buttonText: "Daftar",
                        backgroundColor: secondaryColor,
                        borderRadius: 10,
                        onPressed: () {},
                        buttonTextColor: blackColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
