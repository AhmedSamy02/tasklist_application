import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthParagraph extends StatelessWidget {
  const AuthParagraph({
    super.key,
    required this.title,
    required this.subtitle,
    required this.titleFontSize,
    required this.subtitleFontSize,
  });
  final String title;
  final String subtitle;
  final double titleFontSize;
  final double subtitleFontSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            title,
            style: GoogleFonts.cookie(
                fontSize: titleFontSize, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: subtitleFontSize,
          ),
        ),
      ],
    );
  }
}
