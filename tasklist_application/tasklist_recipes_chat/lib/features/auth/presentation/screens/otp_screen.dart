import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:tasklist_recipes_chat/core/constants/assets.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_paragraph.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    final email = data['email'] as String;
    final forget = data['forget']as bool;
    final pinController = TextEditingController();
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[600]!),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.indigo),
      borderRadius: BorderRadius.circular(8),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: Colors.deepPurpleAccent,
        ),
        textStyle: TextStyle(color: Colors.white, fontSize: 20.sp));
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.redAccent,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(18.sp),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              SvgPicture.asset(
                kOtpScreenAsset,
                height: 290.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 28.sp),
                child: AuthParagraph(
                  title: 'OTP Verification',
                  subtitle: 'Please enter the OTP sent to your email',
                  titleFontSize: 34.sp,
                  subtitleFontSize: 18.sp,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: Pinput(
                  pinAnimationType: PinAnimationType.fade,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  errorPinTheme: errorPinTheme,
                  onCompleted: (pin) async {
                    logger.i('Pin = $pin');
                    await AuthController().verifyOtp(
                        controller: pinController,
                        context: context,
                        email: email,
                        otp: pin,
                        forget: forget);
                  },
                  showCursor: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Didn\'t receive the OTP?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      getit.get<AuthController>().sendOTP(
                          context: context, email: email, forget: forget);
                    },
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
