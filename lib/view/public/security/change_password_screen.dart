import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
import 'package:kajian_fikih/viewmodel/security/security_cubit.dart';
import 'package:kajian_fikih/viewmodel/security/security_state.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final changePassFormKey = GlobalKey<FormState>();
  final _newPassTextController = TextEditingController();
  final _confirmNewPassTextController = TextEditingController();

  void _handlePasswordVisibilityToggle() {
    context.read<FormProvider>().changePasswordVisibility();
  }

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
          "Ubah Password",
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
              "Password berhasil diubah !",
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
            key: changePassFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password Baru",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Consumer<FormProvider>(
                  builder: (BuildContext context, FormProvider value,
                      Widget? child) {
                    return TextFormField(
                      controller: _newPassTextController,
                      obscureText: value.isHidden,
                      validator: ((value) => validatePassword(value!)),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: blackTextColor,
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
                        hintText: "Password Baru",
                        labelStyle: GoogleFonts.outfit(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w400),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: whiteColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(width: 1),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Konfirmasi Password Baru",
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Consumer<FormProvider>(
                  builder: (BuildContext context, FormProvider value,
                      Widget? child) {
                    return TextFormField(
                      controller: _confirmNewPassTextController,
                      obscureText: value.isHidden,
                      validator: ((value) => validateConfirmPassword(
                          value!, _newPassTextController.text)),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: blackTextColor,
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
                        hintText: "Konfirmasi Password Baru",
                        labelStyle: GoogleFonts.outfit(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w400),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: whiteColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(width: 1),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                  buttonText: "Konfirmasi",
                  backgroundColor: buttonBlueColor,
                  borderRadius: 10,
                  onPressed: () {
                    if (changePassFormKey.currentState!.validate()) {
                      context
                          .read<SecurityCubit>()
                          .updatePassword(_newPassTextController.text);
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
