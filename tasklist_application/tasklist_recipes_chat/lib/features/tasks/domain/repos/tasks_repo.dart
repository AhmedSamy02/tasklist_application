import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/features/tasks/data/models/tasklist.dart';

abstract class TasksRepo {
  Future<Either<Failure,List<TaskList>>>getTaskLists();
  Future<Either<Failure,void>>createTaskList(String title, String description);
  Future<Either<Failure,void>>deleteTaskList(String title);
  Future<Either<Failure,void>>updateTaskList(TaskList taskList);
}