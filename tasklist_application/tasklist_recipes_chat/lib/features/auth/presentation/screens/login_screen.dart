import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasklist_recipes_chat/core/constants/assets.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/email_textfield.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/login_paragraph.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/password_textfield.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 350.sp,
                child: SvgPicture.asset(kLoginAsset),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.sp),
                child: const LoginParagraph(),
              ),
              Column(
                children: [
                  EmailTextfield(
                      emailController: _emailController, enabled: true),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: PasswordTextfield(
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                    ),
                  )
                ],
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
                        onPressed: () {},
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
                padding: EdgeInsets.only(top: 15.sp),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.sp,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
