import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:tasklist_recipes_chat/core/constants/assets.dart';
import 'package:tasklist_recipes_chat/core/constants/screens.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/widgets/onboarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
          totalPage: 4,
          headerBackgroundColor: Colors.white,
          finishButtonText: 'Register',
          finishButtonStyle: const FinishButtonStyle(
            backgroundColor: Colors.black,
          ),
          onFinish: () {
            Navigator.of(context).pushReplacementNamed(kRegisterScreen);
          },
          hasSkip: true,
          indicatorAbove: true,
          indicatorPosition: 30,
          skipTextButton: Text(
            'Skip',
            style: TextStyle(color: Colors.grey[800], fontSize: 18),
          ),
          trailingFunction: () {
            Navigator.of(context).pushReplacementNamed(kLoginScreen);
          },
          trailing: Text(
            'Login',
            style: TextStyle(color: Colors.grey[800], fontSize: 18),
          ),
          background: const [
            SizedBox(),
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ],
          speed: 1.2,
          pageBodies: const [
            OnboardingBody(
              title: 'Chat with your friends',
              description:
                  'Chat with your friends and family members to share your thoughts and ideas.',
              svg: kOnboardingChat,
            ),
            OnboardingBody(
              title: 'Create your tasks',
              description:
                  'Create your tasks and manage them easily with our task manager.',
              svg: kOnboardingTask,
            ),
            OnboardingBody(
              title: 'Find your favorite recipes',
              description:
                  'Find your favorite recipes and share them with your friends.',
              svg: kOnboardingRecipie,
            ),
            OnboardingBody(
              title: 'Share your media',
              description:
                  'Share your media files with your friends and family members.',
              svg: kOnboardingMedia,
            ),
          ]),
    );
  }
}
