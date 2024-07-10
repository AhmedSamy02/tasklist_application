import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginParagraph extends StatelessWidget {
  const LoginParagraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'Login',
            style:
                GoogleFonts.cookie(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
        const Text(
          'Login to access your account',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
