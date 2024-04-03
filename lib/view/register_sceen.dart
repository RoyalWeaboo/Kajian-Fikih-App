import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/constants/location.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/dashboard_screen.dart';
import 'package:kajian_fikih/view/question_screen.dart';
import 'package:kajian_fikih/viewmodel/auth/auth_cubit.dart';
import 'package:kajian_fikih/viewmodel/auth/auth_state.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
import 'package:kajian_fikih/viewmodel/question_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerFormKey = GlobalKey<FormState>();
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
      body: BlocListener<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is LoadingState) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const Dialog(
                  insetPadding: EdgeInsets.all(12),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          }
          if (state is RegisterErrorState) {
            Navigator.pop(context);
            AnimatedSnackBar.material(
              state.errorMessage,
              type: AnimatedSnackBarType.error,
              snackBarStrategy: RemoveSnackBarStrategy(),
            ).show(context);
          }
          if (state is RegisterSuccessState) {
            AnimatedSnackBar.material(
              "Selamat Datang ${state.userDetail.username} !",
              type: AnimatedSnackBarType.info,
              snackBarStrategy: RemoveSnackBarStrategy(),
            ).show(context);

            Navigator.pushReplacement(
              context,
              SlideLeftAnimation(
                page: const JamaahDashboardScreen(),
              ),
            );
          }
        },
        child: Container(
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
                    key: registerFormKey,
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
                              validator: ((value) =>
                                  validatePhoneNumber(value!)),
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        8,
                                      ),
                                    ),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: DropdownButton(
                                      value: value.location,
                                      items: Location.values.map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.name,
                                            style: GoogleFonts.outfit(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: blackColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (Location? loc) {
                                        value.location = loc!;
                                      },
                                    ),
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
                            Consumer<FormProvider>(
                              builder: (BuildContext context,
                                  FormProvider value, Widget? child) {
                                return CustomButton(
                                  buttonText: "Daftar",
                                  backgroundColor: secondaryColor,
                                  borderRadius: 10,
                                  onPressed: () {
                                    if (registerFormKey.currentState!
                                            .validate() &&
                                        value.isAgreed) {
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Batal",
                                                            style: GoogleFonts
                                                                .outfit(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                                            Navigator.pop(
                                                                context);
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
                                                            style: GoogleFonts
                                                                .outfit(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                        context.read<AuthCubit>().register(
                                              _usernameController.text,
                                              _emailController.text,
                                              _phoneController.text,
                                              _passwordController.text,
                                              value.location.toString(),
                                              "",
                                              "jamaah",
                                            );
                                      }
                                    } else if (!value.isAgreed) {
                                      AnimatedSnackBar.material(
                                        "Anda perlu menyetujui persyaratan dan privasi yang kami terapkan",
                                        type: AnimatedSnackBarType.info,
                                        snackBarStrategy:
                                            RemoveSnackBarStrategy(),
                                      ).show(context);
                                    }
                                  },
                                  buttonTextColor: blackColor,
                                );
                              },
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
      ),
    );
  }
}
