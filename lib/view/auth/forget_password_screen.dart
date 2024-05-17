import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/viewmodel/security/security_cubit.dart';
import 'package:kajian_fikih/viewmodel/security/security_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final forgetPassFormKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: blackTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<SecurityCubit, SecurityState>(
        listener: (context, state) {
          if (state is SecurityLoadingState) {
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
          if (state is SecurityErrorState) {
            Navigator.pop(context);
            AnimatedSnackBar.material(
              state.errorMessage,
              type: AnimatedSnackBarType.error,
              snackBarStrategy: RemoveSnackBarStrategy(),
            ).show(context);
          }
          if (state is SecuritySuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            AnimatedSnackBar.material(
              "Berhasil ! cek email anda untuk mereset password.",
              type: AnimatedSnackBarType.success,
              snackBarStrategy: RemoveSnackBarStrategy(),
            ).show(context);
          }
        },
        child: Container(
          color: whiteColor,
          height:
              height - (MediaQuery.of(context).padding.top + kToolbarHeight),
          width: width,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Form(
            key: forgetPassFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Alamat Email",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (value) => validateEmail(value!),
                  controller: _emailTextController,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                  cursorColor: secondaryColor,
                  decoration: InputDecoration(
                    isDense: true,
                    counterText: "",
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: whiteColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      borderSide: const BorderSide(
                        width: 1,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  buttonText: "Konfirmasi",
                  backgroundColor: buttonBlueColor,
                  borderRadius: 10,
                  onPressed: () {
                    if (forgetPassFormKey.currentState!.validate()) {
                      context
                          .read<SecurityCubit>()
                          .resetPassword(_emailTextController.text);
                    }
                  },
                  buttonTextColor: whiteColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
