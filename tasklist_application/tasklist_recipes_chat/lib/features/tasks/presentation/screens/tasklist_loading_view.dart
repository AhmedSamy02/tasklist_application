import 'package:flutter/material.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/widgets/loading_tasklist_item.dart';

class TasklistLoadingView extends StatelessWidget {
  const TasklistLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          LoadingTasklistItem(),
          LoadingTasklistItem(),
          LoadingTasklistItem(),
          LoadingTasklistItem(),
        ],
      ),
    );
  }
}
