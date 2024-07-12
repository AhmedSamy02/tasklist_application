import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasklist_recipes_chat/core/constants/assets.dart';
import 'package:tasklist_recipes_chat/core/constants/screens.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_elevated_button.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_outlinded_elevated_button.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/email_textfield.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/auth_paragraph.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/password_textfield.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = getit.get<AuthController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                kLoginAsset,
                height: 275.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.sp),
                child: const AuthParagraph(
                  title: 'Login',
                  subtitle: 'Please enter your email and password',
                  titleFontSize: 48,
                  subtitleFontSize: 18,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    EmailTextfield(
                        emailController: _emailController, enabled: true),
                    Padding(
                      padding: EdgeInsets.only(top: 18.sp),
                      child: PasswordTextfield(
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.sp),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Divider(
                      color: Colors.indigo[300],
                      endIndent: 10.sp,
                      indent: 10.sp,
                    ),
                    Container(
                      color: Colors.white,
                      width: 160.w,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(kEmailScreen, arguments: true);
                        },
                        child: Text(
                          'Forget password ?',
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.sp),
                child: AuthElevatedButton(
                  text: 'Login',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.login(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.sp),
                child: AuthOutlinedElevatedButton(
                  text: 'Register',
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(kEmailScreen, arguments: false);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
