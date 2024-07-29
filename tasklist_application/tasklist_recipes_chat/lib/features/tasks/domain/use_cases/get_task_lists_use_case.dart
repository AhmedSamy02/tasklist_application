import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case.dart';
import 'package:tasklist_recipes_chat/features/tasks/data/models/tasklist.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/repos/tasks_repo.dart';

class GetTaskListsUseCase implements UseCase<List<TaskList>> {
  final TasksRepo tasksRepo;

  GetTaskListsUseCase({required this.tasksRepo});

  @override
  Future<Either<Failure, List<TaskList>>> call() {
    return tasksRepo.getTaskLists();
  }
}
