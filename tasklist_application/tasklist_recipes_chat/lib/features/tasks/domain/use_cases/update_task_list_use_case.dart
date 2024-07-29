import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/tasks/data/models/tasklist.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/repos/tasks_repo.dart';

class UpdateTaskListUseCase implements UseCaseWithOneParam<void, TaskList> {
  final TasksRepo tasksRepo;

  UpdateTaskListUseCase(this.tasksRepo);

  @override
  Future<Either<Failure, void>> call(TaskList taskList) {
    return tasksRepo.updateTaskList(taskList);
  }
}
