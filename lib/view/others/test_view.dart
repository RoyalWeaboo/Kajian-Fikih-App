// ignore_for_file: unused_field

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/validators/validator.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/viewmodel/test_viewmodel.dart/test_cubit.dart';
import 'package:kajian_fikih/viewmodel/test_viewmodel.dart/test_state.dart';

class TestViewScreen extends StatefulWidget {
  const TestViewScreen({super.key});

  @override
  State<TestViewScreen> createState() => _TestViewScreenState();
}

//THIS VIEW IS FOR DEVELOPMENT PURPOSE ONLY
class _TestViewScreenState extends State<TestViewScreen> {
  final formKey = GlobalKey<FormState>();
  final _questionTextController = TextEditingController();
  final _aTextController = TextEditingController();
  final _bTextController = TextEditingController();
  final _cTextController = TextEditingController();
  final _dTextController = TextEditingController();
  final _correctAnswerTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: BlocListener<TestViewModelCubit, TestViewModelState>(
          listener: (context, state) {
            if (state is TestViewModelLoadingState) {
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
            if (state is TestViewModelErrorState) {
              Navigator.pop(context);
              AnimatedSnackBar.material(
                state.errorMessage,
                type: AnimatedSnackBarType.error,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);
            }
            if (state is TestViewModelSuccessState) {
              Navigator.pop(context);
              AnimatedSnackBar.material(
                "Question Added",
                type: AnimatedSnackBarType.success,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);
            }
          },
          child: SingleChildScrollView(
            child: Container(
              color: whiteColor,
              height: height,
              width: width,
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        "Question",
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
                        validator: (value) => validateInput(value!),
                        controller: _questionTextController,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
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
                      Text(
                        "Answer a",
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
                        validator: (value) => validateInput(value!),
                        controller: _aTextController,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
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
                      Text(
                        "Answer b",
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
                        validator: (value) => validateInput(value!),
                        controller: _bTextController,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
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
                      Text(
                        "Answer c",
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
                        validator: (value) => validateInput(value!),
                        controller: _cTextController,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
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
                      Text(
                        "answer d",
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
                        validator: (value) => validateInput(value!),
                        controller: _dTextController,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
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
                      Text(
                        "Correct Answer (a / b / c /d)",
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
                        validator: (value) => validateInput(value!),
                        controller: _correctAnswerTextController,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
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
                          if (formKey.currentState!.validate()) {
                            context.read<TestViewModelCubit>().postQuestion(
                                  _questionTextController.text,
                                  _aTextController.text,
                                  _bTextController.text,
                                  _cTextController.text,
                                  _dTextController.text,
                                  _correctAnswerTextController.text,
                                );
                          }
                        },
                        buttonTextColor: whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
