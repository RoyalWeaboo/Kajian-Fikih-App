import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/preferences/preferences_utils.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/view/jamaah/dashboard/dashboard_screen.dart';
import 'package:kajian_fikih/view/register_sceen.dart';
import 'package:kajian_fikih/view/ustadz/dashboard/ustadz_dashboard_screen.dart';
import 'package:kajian_fikih/viewmodel/auth/auth_cubit.dart';
import 'package:kajian_fikih/viewmodel/auth/auth_state.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late PreferencesUtils preferencesUtils;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await initPreferences();
    checkSession();
  }

  void checkSession() {
    final currUser = FirebaseAuth.instance.currentUser;
    if (currUser != null) {
      final role = preferencesUtils.getPreferencesString("role");
      if (role == "ustadz") {
        Navigator.pushReplacement(
          context,
          SlideLeftAnimation(
            page: const UstadzDashboardScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          SlideLeftAnimation(
            page: const JamaahDashboardScreen(),
          ),
        );
      }
    }
  }

  void _handlePasswordVisibilityToggle() {
    context.read<FormProvider>().changePasswordVisibility();
  }

  Future initPreferences() async {
    preferencesUtils = PreferencesUtils();
    await preferencesUtils.init();
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
          if (state is LoginErrorState) {
            Navigator.pop(context);
            AnimatedSnackBar.material(
              state.errorMessage,
              type: AnimatedSnackBarType.error,
              snackBarStrategy: RemoveSnackBarStrategy(),
            ).show(context);
          }
          if (state is GoogleLoginErrorState) {
            Navigator.pop(context);
            AnimatedSnackBar.material(
              state.errorMessage,
              type: AnimatedSnackBarType.error,
              snackBarStrategy: RemoveSnackBarStrategy(),
            ).show(context);
          }
          if (state is LoginSuccessState) {
            if (state.userDetail.role == "ustadz") {
              preferencesUtils.savePreferencesBool("googleLogin", false);
              AnimatedSnackBar.material(
                "Selamat Datang Ust.${state.userDetail.username} !",
                type: AnimatedSnackBarType.info,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);

              Navigator.pushReplacement(
                context,
                SlideLeftAnimation(
                  page: const UstadzDashboardScreen(),
                ),
              );
            } else {
              preferencesUtils.savePreferencesBool("googleLogin", false);
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
          }
          if (state is GoogleLoginSuccessState) {
            preferencesUtils.savePreferencesBool("googleLogin", true);
            AnimatedSnackBar.material(
              "Selamat Datang ${state.user.displayName} !",
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
        child: SingleChildScrollView(
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
                              Consumer<FormProvider>(
                                builder: (BuildContext context,
                                    FormProvider value, Widget? child) {
                                  return TextFormField(
                                    controller: _passwordController,
                                    obscureText: value.isHidden,
                                    validator: ((value) =>
                                        validatePassword(value!)),
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
                                  );
                                },
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
                                  if (loginFormKey.currentState!.validate()) {
                                    context.read<AuthCubit>().login(
                                          _emailController.text,
                                          _passwordController.text,
                                        );
                                  }
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
                              context.read<AuthCubit>().loginWithGoogle();
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
      ),
    );
  }
}
