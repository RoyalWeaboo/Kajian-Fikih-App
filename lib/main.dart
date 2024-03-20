import 'package:flutter/material.dart';
import 'package:kajian_fikih/view/splash_screen.dart';
import 'package:kajian_fikih/viewmodel/bottom_navbar_provider.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
import 'package:kajian_fikih/viewmodel/question_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BottomNavbarComponentViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuestionProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kajian Fikih',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
