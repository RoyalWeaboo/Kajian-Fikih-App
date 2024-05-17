import 'dart:math';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/model/questions.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/view/auth/login_screen.dart';
import 'package:kajian_fikih/view/ustadz/dashboard/ustadz_dashboard_screen.dart';
import 'package:kajian_fikih/viewmodel/auth/auth_cubit.dart';
import 'package:kajian_fikih/viewmodel/auth/auth_state.dart';
import 'package:kajian_fikih/viewmodel/question/question_cubit.dart';
import 'package:kajian_fikih/viewmodel/question/question_state.dart';
import 'package:kajian_fikih/viewmodel/question_provider.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatefulWidget {
  final UserDetail registrationDetail;
  final String password;
  const QuestionScreen({
    super.key,
    required this.registrationDetail,
    required this.password,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QuestionCubit>().getQuestionList();
  }

  resetTimer() {
    context.read<QuestionProvider>().resetTimerDuration();
  }

  startTimer() {
    context.read<QuestionProvider>().startCountdownTimer();
  }

  List<Question> getRandomQuestions(List<Question> allQuestions, int count) {
    final random = Random();
    List<Question> selectedQuestions = [];
    Set<int> selectedIndices = {};

    while (selectedQuestions.length < count) {
      int index = random.nextInt(allQuestions.length);
      if (!selectedIndices.contains(index)) {
        selectedIndices.add(index);
        selectedQuestions.add(allQuestions[index]);
      }
    }

    return selectedQuestions;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: whiteColor,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, AuthState authState) {
            if (authState is RegisterSuccessState) {
              AnimatedSnackBar.material(
                "Registrasi berhasil, Selamat Datang ${authState.userDetail.username} !",
                type: AnimatedSnackBarType.info,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);

              Navigator.pushReplacement(
                context,
                SlideLeftAnimation(
                  page: const UstadzDashboardScreen(),
                ),
              );
            }
            if (authState is RegisterErrorState) {
              AnimatedSnackBar.material(
                authState.errorMessage,
                type: AnimatedSnackBarType.error,
                snackBarStrategy: RemoveSnackBarStrategy(),
              ).show(context);
            }
          },
          child: BlocConsumer<QuestionCubit, QuestionState>(
            listener: (context, state) {
              if (state is QuestionErrorState) {
                AnimatedSnackBar.material(
                  state.errorMessage,
                  type: AnimatedSnackBarType.error,
                  snackBarStrategy: RemoveSnackBarStrategy(),
                ).show(context);
              }
              if (state is QuestionSuccessState) {
                final randomQuestionList = getRandomQuestions(
                  state.questionsList,
                  10,
                );
                Provider.of<QuestionProvider>(context).question =
                    randomQuestionList;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Reset timer duration and start timer after the build phase is complete
                  resetTimer();
                  startTimer();
                });
              }
            },
            builder: (context, state) {
              if (state is QuestionLoadingState) {
                return SizedBox(
                  height: height,
                  width: width,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              if (state is QuestionSuccessState) {
                return SingleChildScrollView(
                  child: Consumer<QuestionProvider>(
                    builder: (BuildContext context, QuestionProvider value,
                        Widget? child) {
                      if (value.timerDuration > 0) {
                        return SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    value.questionNumber.toString(),
                                    style: GoogleFonts.outfit(
                                      fontSize: 16,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "/10",
                                    style: GoogleFonts.outfit(
                                      fontSize: 16,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/timer_background.png',
                                      width: width * 0.25,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Text(
                                      "${value.timerDuration.toString()}s",
                                      style: GoogleFonts.outfit(
                                        fontSize: 24,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 64,
                              ),
                              Text(
                                "Pertanyaan ${value.questionNumber.toString()}",
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                value.question[value.questionNumber - 1]
                                    .question,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: primaryColor,
                                    value: "a",
                                    groupValue: value.answer,
                                    onChanged: (String? val) {
                                      value.answer = val!;
                                    },
                                  ),
                                  Flexible(
                                    child: Text(
                                      value
                                          .question[value.questionNumber - 1].a,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: primaryColor,
                                    value: "b",
                                    groupValue: value.answer,
                                    onChanged: (String? val) {
                                      value.answer = val!;
                                    },
                                  ),
                                  Flexible(
                                    child: Text(
                                      value
                                          .question[value.questionNumber - 1].b,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: primaryColor,
                                    value: "c",
                                    groupValue: value.answer,
                                    onChanged: (String? val) {
                                      value.answer = val!;
                                    },
                                  ),
                                  Flexible(
                                    child: Text(
                                      value
                                          .question[value.questionNumber - 1].c,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: primaryColor,
                                    value: "d",
                                    groupValue: value.answer,
                                    onChanged: (String? val) {
                                      value.answer = val!;
                                    },
                                  ),
                                  Flexible(
                                    child: Text(
                                      value
                                          .question[value.questionNumber - 1].d,
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 48,
                              ),
                              CustomButton(
                                buttonText: "Selanjutnya",
                                backgroundColor: secondaryColor,
                                borderRadius: 10,
                                onPressed: () {
                                  //check if answer is correct
                                  if (value.answer ==
                                      value.question[value.questionNumber - 1]
                                          .correctAnswer) {
                                    context
                                        .read<QuestionProvider>()
                                        .incrementRightAnswerCount();
                                  }

                                  //continue to the next question
                                  if (value.questionNumber < 10) {
                                    //increment the question number
                                    context
                                        .read<QuestionProvider>()
                                        .incrementQuestionNumber();

                                    //restart the timer
                                    resetTimer();
                                    startTimer();
                                  } else {
                                    if (value.rightAnswerCount >= 8) {
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
                                                  "Hasil Test",
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
                                                  "Selamat, Anda dinyatakan Lulus !\nNilai Anda : ${value.rightAnswerCount * 10}",
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: blackColor,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: TextButton(
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
                                                      //register as ustadz
                                                      context
                                                          .read<AuthCubit>()
                                                          .register(
                                                            widget
                                                                .registrationDetail
                                                                .username,
                                                            widget
                                                                .registrationDetail
                                                                .email,
                                                            widget
                                                                .registrationDetail
                                                                .phone,
                                                            widget.password,
                                                            widget
                                                                .registrationDetail
                                                                .location,
                                                            widget
                                                                .registrationDetail
                                                                .profilePictureUrl,
                                                            widget
                                                                .registrationDetail
                                                                .role,
                                                          );
                                                    },
                                                    child: Text(
                                                      "Lanjutkan Registrasi",
                                                      style: GoogleFonts.outfit(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: blackColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else {
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
                                                  "Hasil Test",
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
                                                  "Maaf, Anda Gagal !\nNilai Anda : ${value.rightAnswerCount * 10}",
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: blackColor,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: TextButton(
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
                                                              const LoginScreen(),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Konfirmasi",
                                                      style: GoogleFonts.outfit(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: blackColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                                buttonTextColor: blackColor,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          height: height,
                          width: width,
                          color: whiteColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 24,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/main_logo.png",
                                width: 120,
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Mohon maaf anda gagal",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Alasan : Waktu Habis",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              CustomButton(
                                buttonText: "Kembali Ke Halaman Login",
                                backgroundColor: primaryColor,
                                borderRadius: 10,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    SlideLeftAnimation(
                                      page: const LoginScreen(),
                                    ),
                                  );
                                },
                                buttonTextColor: whiteColor,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
