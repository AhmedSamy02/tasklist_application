import 'package:tasklist_recipes_chat/features/tasks/data/models/tasklist.dart';

class TasklistStates {}

class TasklistInitialState extends TasklistStates {}

class TasklistLoadingState extends TasklistStates {}

class TasklistCompletedState extends TasklistStates {
  final List<TaskList> tasks;

  TasklistCompletedState({required this.tasks});
}

class TasklistErrorState extends TasklistStates {
  final String message;

  TasklistErrorState({required this.message});
}

class TasklistEmptyState extends TasklistStates {}
