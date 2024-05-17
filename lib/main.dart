import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/firebase_options.dart';
import 'package:kajian_fikih/utils/constants/color.dart';
import 'package:kajian_fikih/view/others/splash_screen.dart';
import 'package:kajian_fikih/viewmodel/auth/auth_cubit.dart';
import 'package:kajian_fikih/viewmodel/bottom_navbar_provider.dart';
import 'package:kajian_fikih/viewmodel/dashboard_ustadz/dashboard_event.cubit.dart';
import 'package:kajian_fikih/viewmodel/dashboard_jamaah/dashboard_jamaah_cubit.dart';
import 'package:kajian_fikih/viewmodel/follow_user/follow_cubit.dart';
import 'package:kajian_fikih/viewmodel/liked_post/liked_post_cubit.dart';
import 'package:kajian_fikih/viewmodel/form_provider.dart';
import 'package:kajian_fikih/viewmodel/history/history_cubit.dart';
import 'package:kajian_fikih/viewmodel/post_comment/post_comment_cubit.dart';
import 'package:kajian_fikih/viewmodel/post_utils/like_post/like_post_cubit.dart';
import 'package:kajian_fikih/viewmodel/notification/notification_cubit.dart';
import 'package:kajian_fikih/viewmodel/post/post_cubit.dart';
import 'package:kajian_fikih/viewmodel/profile_jamaah/profile_cubit.dart';
import 'package:kajian_fikih/viewmodel/profile_ustadz/profile_ustadz_cubit.dart';
import 'package:kajian_fikih/viewmodel/question/question_cubit.dart';
import 'package:kajian_fikih/viewmodel/question_provider.dart';
import 'package:kajian_fikih/viewmodel/post_utils/save_post/save_post_cubit.dart';
import 'package:kajian_fikih/viewmodel/saved_post/saved_post_cubit.dart';
import 'package:kajian_fikih/viewmodel/security/security_cubit.dart';
import 'package:kajian_fikih/viewmodel/user_detail/user_detail_cubit.dart';
import 'package:provider/provider.dart';

// import 'package:kajian_fikih/view/test_view.dart';
// import 'package:kajian_fikih/viewmodel/test_viewmodel.dart/test_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return AuthCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return ProfileCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return ProfileUstadzCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return PostCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return LikePostCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return SavePostCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return FollowCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return DashboardEventCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return LikedPostCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return NotificationCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return HistoryCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return DashboardJamaahCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return PostCommentCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return UserDetailCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return SecurityCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return SavedPostCubit();
          },
        ),
        BlocProvider(
          create: (context) {
            return QuestionCubit();
          },
        ),
        //For Dev purpose
        // BlocProvider(
        //   create: (context) {
        //     return TestViewModelCubit();
        //   },
        // ),
      ],
      child: MultiProvider(
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
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      //For Dev purpose
      // home: const TestViewScreen(),
    );
  }
}
