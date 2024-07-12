import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasklist_recipes_chat/core/constants/assets.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_paragraph.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/email_textfield.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final forget = ModalRoute.of(context)!.settings.arguments as bool;
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
          physics: const ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          child: Column(
            children: [
              SvgPicture.asset(
                kEmailScreenAsset,
                height: 290.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 28.sp),
                child: AuthParagraph(
                  title: forget ? 'Forget Password ?' : 'Email Verification',
                  subtitle: 'Please enter your email',
                  titleFontSize: 33.sp,
                  subtitleFontSize: 20.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.sp),
                child: Form(
                  key: formKey,
                  child: EmailTextfield(
                    emailController: emailController,
                    enabled: true,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
              AuthElevatedButton(
                text: 'Verify',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final controller = getit.get<AuthController>();
                    controller.sendOTP(
                      context: context,
                      email: emailController.text,
                      forget: forget,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
