import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasklist_recipes_chat/core/constants/methods.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/core/errors/unauthorized_failure.dart';
import 'package:tasklist_recipes_chat/features/tasks/data/models/tasklist.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/repos/tasks_repo.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/use_cases/create_task_list_use_case.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/use_cases/delete_task_list_use_case.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/use_cases/get_task_lists_use_case.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/use_cases/update_task_list_use_case.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/controllers/tasklist_states.dart';

class TasklistCubit extends Cubit<TasklistStates> {
  final TasksRepo _tasksRepo;

  TasklistCubit(this._tasksRepo) : super(TasklistInitialState());

  void getTasklist({required BuildContext context}) async {
    emit(TasklistLoadingState());
    try {
      final tasks = await GetTaskListsUseCase(tasksRepo: _tasksRepo).call();
      tasks.fold((failure) async {
        logger.e('Error: ${failure.message}');
        switch (failure.runtimeType) {
          case const (UnauthorizedFailure):
            await checkToken(context: context);
            break;
          default:
            showErrorQuickAlert(context: context, text: failure.message);
            emit(TasklistErrorState(message: failure.message));
            break;
        }
      }, (taskLists) {
        if (taskLists.isEmpty) {
          emit(TasklistEmptyState());
        } else {
          emit(TasklistCompletedState(tasks: taskLists));
        }
      });
    } catch (e) {
      emit(TasklistErrorState(message: e.toString()));
    }
  }

  void deleteTasklist(
      {required String title, required BuildContext context}) async {
    emit(TasklistLoadingState());
    try {
      final tasks = await DeleteTaskListUseCase(_tasksRepo).call(title);
      tasks.fold((failure) async {
        logger.e('Error: ${failure.message}');
        switch (failure.runtimeType) {
          case const (UnauthorizedFailure):
            await checkToken(context: context);
            break;
          default:
            showErrorQuickAlert(context: context, text: failure.message);
            emit(TasklistErrorState(message: failure.message));
            break;
        }
      }, (none) {
        getTasklist(context: context);
      });
    } catch (e) {
      emit(TasklistErrorState(message: e.toString()));
    }
  }

  void createTasklist(
      {required String title,
      required String description,
      required BuildContext context}) async {
    emit(TasklistLoadingState());
    try {
      final tasks =
          await CreateTaskListUseCase(_tasksRepo).call(title, description);
      tasks.fold((failure) async {
        logger.e('Error: ${failure.message}');
        switch (failure.runtimeType) {
          case const (UnauthorizedFailure):
            await checkToken(context: context);
            break;
          default:
            showErrorQuickAlert(context: context, text: failure.message);
            emit(TasklistErrorState(message: failure.message));
            break;
        }
      }, (none) {
        getTasklist(context: context);
      });
    } catch (e) {
      emit(TasklistErrorState(message: e.toString()));
    }
  }

  void updateTasklist(
      {required TaskList tasklist, required BuildContext context}) async {
    emit(TasklistLoadingState());
    try {
      final tasks = await UpdateTaskListUseCase(_tasksRepo).call(
        tasklist,
      );
      tasks.fold((failure) async {
        logger.e('Error: ${failure.message}');
        switch (failure.runtimeType) {
          case const (UnauthorizedFailure):
            await checkToken(context: context);
            break;
          default:
            showErrorQuickAlert(context: context, text: failure.message);
            emit(TasklistErrorState(message: failure.message));
            break;
        }
      }, (none) {
        getTasklist(context: context);
      });
    } catch (e) {
      emit(TasklistErrorState(message: e.toString()));
    }
  }
}
