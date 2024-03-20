import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kajian_fikih/model/dummy_question.dart';
import 'package:kajian_fikih/utils/animations/slide_left.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/utils/widgets/custom_button.dart';
import 'package:kajian_fikih/view/login_screen.dart';
import 'package:kajian_fikih/viewmodel/question_provider.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset timer duration and start timer after the build phase is complete
      resetTimer();
      startTimer();
    });
  }

  resetTimer() {
    context.read<QuestionProvider>().resetTimerDuration();
  }

  startTimer() {
    context.read<QuestionProvider>().startCountdownTimer();
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
        child: SingleChildScrollView(
          child: Consumer<QuestionProvider>(
            builder:
                (BuildContext context, QuestionProvider value, Widget? child) {
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
                        dummyQuestion[0].question,
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
                              dummyQuestion[0].a,
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
                              dummyQuestion[0].b,
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
                              dummyQuestion[0].c,
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
                              dummyQuestion[0].d,
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
                          if (value.answer == dummyQuestion[0].correctAnswer) {
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

                            //reload for new question
                            Navigator.pushReplacement(
                              context,
                              SlideLeftAnimation(
                                page: const QuestionScreen(),
                              ),
                            );
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
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              //reset question number
                                              context
                                                  .read<QuestionProvider>()
                                                  .resetQuestionNumber();
                                              //reset answer count
                                              context
                                                  .read<QuestionProvider>()
                                                  .resetRightAnswerCount();
                                              //close dialog
                                              Navigator.pop(context);
                                              //navigate to login screen
                                              Navigator.push(
                                                context,
                                                SlideLeftAnimation(
                                                  page: const LoginScreen(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Lanjutkan",
                                              style: GoogleFonts.outfit(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
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
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              //reset question number
                                              context
                                                  .read<QuestionProvider>()
                                                  .resetQuestionNumber();
                                              //reset answer count
                                              context
                                                  .read<QuestionProvider>()
                                                  .resetRightAnswerCount();
                                              //close dialog
                                              Navigator.pop(context);
                                              //navigate to question screen
                                              Navigator.push(
                                                context,
                                                SlideLeftAnimation(
                                                  page: const LoginScreen(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Lanjutkan",
                                              style: GoogleFonts.outfit(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
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
        ),
      ),
    );
  }
}
