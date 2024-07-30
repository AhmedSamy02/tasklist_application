import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/controllers/tasklist_cubit.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/controllers/tasklist_states.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/screens/tasklist_completed_view.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/screens/tasklist_error_view.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/screens/tasklist_loading_view.dart';

class TasklistScreen extends StatelessWidget {
  const TasklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasklistCubit, TasklistStates>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (TasklistCompletedState):
            return TasklistCompletedView(
              list: (state as TasklistCompletedState).tasklists,
            );
          case const (TasklistErrorState):
            return TasklistErrorView(message: (state as TasklistErrorState).message);
          default:
            return const TasklistLoadingView();
        }
      },
    );
  }
}
