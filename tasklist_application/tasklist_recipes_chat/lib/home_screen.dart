import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasklist_recipes_chat/core/constants/colors.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tasklist_recipes_chat/features/media/data/models/media.dart';
import 'package:tasklist_recipes_chat/features/media/presentation/controllers/media_controller.dart';
import 'package:tasklist_recipes_chat/features/media/presentation/screens/media_screen.dart';
import 'package:tasklist_recipes_chat/features/media/presentation/widgets/add_media_quick_alert.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/screens/recipies_screen.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/repos/tasks_repo.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/controllers/tasklist_cubit.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/screens/tasklist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final colorsList = [kPage1Color, kPage2Color, kPage3Color];
  final textList = ['Task List', 'Recipes', 'Media'];
  static const _pageSize = 10;

  bool fromNavigaion = false;
  final PageController _pageController = PageController();
  int index = 0;
  final pagingController = PagingController<int, Media>(
    firstPageKey: 0,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    pagingController.addPageRequestListener((pageKey) async {
      await getit.get<MediaController>().getMedia(
            page: pageKey,
            limit: _pageSize,
            controller: pagingController,
            context: context,
          );
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final widgetsList = [
      const TasklistScreen(),
      const RecipiesScreen(),
      MediaScreen(
        pagingController: pagingController,
      ),
    ];
    final List<Widget?> fabList = [
      null,
      null,
      FloatingActionButton(
        onPressed: () async {
          await AddMediaQuickAlert.show(
            context: context,
            nameController: TextEditingController(),
            picker: ImagePicker(),
            pageController: pagingController,
          );
        },
        backgroundColor: Colors.blueGrey[800],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      )
    ];
    return BlocProvider<TasklistCubit>(
      create: (context) => TasklistCubit(
        getit.get<TasksRepo>(),
      )..getTasklist(context: context),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
              },
              icon: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: ()async {
                await getit.get<AuthController>().logout(context);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
            ),
            
          ],
          title: Text(
            textList[index],
            style: const TextStyle(color: Colors.white),
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
        floatingActionButton: fabList[index],
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
      ),
    );
  }
}
