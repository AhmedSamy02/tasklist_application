import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/repos/tasks_repo.dart';

class DeleteTaskListUseCase implements UseCaseWithOneParam<void, String> {
  final TasksRepo tasksRepo;

  DeleteTaskListUseCase(this.tasksRepo);

  @override
  Future<Either<Failure, void>> call(String title) {
    return tasksRepo.deleteTaskList(title);
  }
}
