import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingParagraph extends StatelessWidget {
  const OnboardingParagraph({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(title,
              style: GoogleFonts.cookie(
                  fontSize: 45, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(description, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
