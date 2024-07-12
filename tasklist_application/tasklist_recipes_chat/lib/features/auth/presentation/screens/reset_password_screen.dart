import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasklist_recipes_chat/core/constants/assets.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_paragraph.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/fancy_auth_field.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/password_textfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final passwordFancyController = FancyPasswordController();
    final confirmPasswordController = TextEditingController();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                kResetPasswordAsset,
                height: 180.h,
              ),
              AuthParagraph(
                title: 'Reset Password',
                subtitle: 'Please add your new password',
                titleFontSize: 40.sp,
                subtitleFontSize: 18.sp,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.sp),
                      child: FancyAuthField(
                        passwordController: passwordController,
                        facnyTextEditingController: passwordFancyController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.sp),
                      child: PasswordTextfield(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          labelText: 'Confirm Password',
                          controller: confirmPasswordController,
                          textInputAction: TextInputAction.done),
                    ),
                  ],
                ),
              ),
              AuthElevatedButton(
                  text: 'Reset Password',
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        passwordFancyController.areAllRulesValidated) {
                      final controller = getit.get<AuthController>();
                      controller.resetPassword(
                        context: context,
                        password: passwordController.text,
                        newPassword: confirmPasswordController.text,
                        email: email,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
