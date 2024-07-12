import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasklist_recipes_chat/core/constants/methods.dart';
import 'package:tasklist_recipes_chat/core/constants/screens.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/screens/email_screen.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/screens/login_screen.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/screens/otp_screen.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/screens/register_screen.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/screens/reset_password_screen.dart';

void main() {
  initializeSingletons();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.robotoTextTheme(),
        ),
        initialRoute: kLoginScreen,
        routes: {
          kOnboardingScreen: (context) => const OnboardingScreen(),
          kLoginScreen: (context) => LoginScreen(),
          kEmailScreen: (context) => const EmailScreen(),
          kOtpScreen: (context) => const OtpScreen(),
          kResetPasswordScreen: (context) => const ResetPasswordScreen(),
          kRegisterScreen: (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
