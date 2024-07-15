import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tasklist_recipes_chat/core/constants/colors.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/screens/recipies_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final colorsList = [kPage1Color, kPage2Color, kPage3Color];
  final textList = ['Task List', 'Recipes', 'Media'];
  final widgetsList = [
    const Placeholder(),
    const RecipiesScreen(),
    const Placeholder(),
  ];
  bool fromNavigaion = false;
  final PageController _pageController = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textList[index],
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colorsList[index],
      ),
      body: PageView(
        controller: _pageController,
        children: widgetsList,
        onPageChanged: (index) {
          if (!fromNavigaion) {
            setState(() {
              this.index = index;
            });
          }
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInOut,
        animationDuration: Durations.long2,
        backgroundColor: colorsList[index],
        index: index,
        items: [
          Icon(
            Icons.list,
            size: 30,
            color: colorsList[0],
          ),
          Icon(
            Icons.fastfood,
            size: 30,
            color: colorsList[1],
          ),
          Icon(
            Icons.perm_media,
            size: 30,
            color: colorsList[2],
          ),
        ],
        onTap: (index) async {
          fromNavigaion = true;
          await _pageController.animateToPage(index,
              duration: Durations.long2, curve: Curves.easeInOut);
          fromNavigaion = false;
          setState(() {
              this.index = index;
            });
        },
      ),
    );
  }
}
