import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/view/login_screen.dart';
import 'package:kajian_fikih/view/question_screen.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
import 'package:kajian_fikih/viewmodel/question_provider.dart';
import 'package:provider/provider.dart';

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

  void _handlePasswordVisibilityToggle() {
    context.read<FormProvider>().changePasswordVisibility();
  }

  void _handleConfirmPasswordVisibilityToggle() {
    context.read<FormProvider>().changeConfirmPasswordVisibility();
  }

  void _handleAgreementToggle() {
    context.read<FormProvider>().changeAgreementStatus();
  }

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
                  child: Consumer<FormProvider>(
                    builder: (
                      BuildContext context,
                      FormProvider value,
                      Widget? child,
                    ) {
                      return Column(
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
                            obscureText: value.isHidden,
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
                              suffixIcon: InkWell(
                                onTap: _handlePasswordVisibilityToggle,
                                child: Icon(
                                  size: 20,
                                  value.isHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
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
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(width: 1),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: value.isConfirmHidden,
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
                              suffixIcon: InkWell(
                                onTap: _handleConfirmPasswordVisibilityToggle,
                                child: Icon(
                                  size: 20,
                                  value.isConfirmHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              isDense: true,
                              counterText: "",
                              hintText: "Konfirmasi Password",
                              labelStyle: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w400),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: whiteColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(width: 1),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Daftar Sebagai : ",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: whiteColor,
                                    ),
                                  ),
                                  Radio(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      // active
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return secondaryColor;
                                      }
                                      // inactive
                                      return whiteColor;
                                    }),
                                    activeColor: secondaryColor,
                                    value: "jamaah",
                                    groupValue: value.role,
                                    onChanged: (String? val) {
                                      value.role = val!;
                                    },
                                  ),
                                  Text(
                                    "Jamaah",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      // active
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return secondaryColor;
                                      }
                                      // inactive
                                      return whiteColor;
                                    }),
                                    activeColor: secondaryColor,
                                    value: "ustadz",
                                    groupValue: value.role,
                                    onChanged: (String? val) {
                                      value.role = val!;
                                    },
                                  ),
                                  Text(
                                    "Ustadz",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: value.isAgreed,
                                side: const BorderSide(color: outlineColor),
                                checkColor: blackColor,
                                activeColor: secondaryColor,
                                onChanged: (value) {
                                  _handleAgreementToggle();
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
                            onPressed: () {
                              if (value.role == "ustadz") {
                                //show confirmation dialog
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: whiteColor,
                                      title: Row(
                                        children: [
                                          Image.asset(
                                            'assets/info_icon.png',
                                            width: 32,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "Daftar Sebagai Ustadz",
                                            style: GoogleFonts.outfit(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Anda memilih mendaftar sebagai ustadz. Untuk melanjutkan pendaftaran anda perlu menyelesaikan test berupa 10 pertanyaan dengan waktu 30 detik tiap pertanyaan. Lanjutkan Pendaftaran ?",
                                            style: GoogleFonts.outfit(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: blackColor,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Batal",
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    //reset question number
                                                    context
                                                        .read<
                                                            QuestionProvider>()
                                                        .resetQuestionNumber();
                                                    //reset answer count
                                                    context
                                                        .read<
                                                            QuestionProvider>()
                                                        .resetRightAnswerCount();
                                                    //close dialog
                                                    Navigator.pop(context);
                                                    //navigate to question screen
                                                    Navigator.push(
                                                      context,
                                                      SlideLeftAnimation(
                                                        page:
                                                            const QuestionScreen(),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    "Lanjut",
                                                    style: GoogleFonts.outfit(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  SlideLeftAnimation(
                                    page: const LoginScreen(),
                                  ),
                                );
                              }
                            },
                            buttonTextColor: blackColor,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      );
                    },
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
