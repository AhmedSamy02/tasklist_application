import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasklist_recipes_chat/core/constants/assets.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_paragraph.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/email_textfield.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/fancy_auth_field.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/full_name_row.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/gender_row.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/password_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    // final email = 'a1s56c@qweqw.com';
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController(text: email);
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final passwordController = TextEditingController();
    final facnyTextEditingController = FancyPasswordController();
    final confirmPasswordController = TextEditingController();
    String gender = 'Male';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              SvgPicture.asset(
                kRegisterAsset,
                height: 190.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.sp),
                child: AuthParagraph(
                    title: 'Register',
                    subtitle: 'Please enter your details',
                    titleFontSize: 42.sp,
                    subtitleFontSize: 19.sp),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.sp),
                child: FullNameRow(
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.sp),
                child: EmailTextfield(
                  emailController: emailController,
                  enabled: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.sp),
                child: GenderRow(
                  onChanged: (value) {
                    gender = value ?? 'Male';
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.sp),
                child: FancyAuthField(
                  passwordController: passwordController,
                  facnyTextEditingController: facnyTextEditingController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.sp),
                child: PasswordTextfield(
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  labelText: 'Confirm Password',
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.sp),
                child: AuthElevatedButton(
                    text: 'Register',
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          facnyTextEditingController.areAllRulesValidated) {
                        getit.get<AuthController>().register(
                              context: context,
                              email: email,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              password: passwordController.text,
                              gender: gender,
                            );
                      }
                    }),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
