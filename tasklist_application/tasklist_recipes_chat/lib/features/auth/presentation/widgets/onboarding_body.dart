import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/onboarding_paragraph.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody(
      {super.key,
      required this.title,
      required this.description,
      required this.svg});
  final String title;
  final String description;
  final String svg;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Expanded(flex: 8, child: SvgPicture.asset(svg)),
          Expanded(
            flex: 3,
            child: OnboardingParagraph(
              title: title,
              description: description,
            ),
          ),
        ],
      ),
    );
  }
}
