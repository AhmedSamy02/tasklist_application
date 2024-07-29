import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/errors/server_failure.dart';
import 'package:tasklist_recipes_chat/core/errors/unknown_failure.dart';
import 'package:tasklist_recipes_chat/features/tasks/data/data_source/tasks_remote_data_source.dart';
import 'package:tasklist_recipes_chat/features/tasks/data/models/tasklist.dart';
import 'package:tasklist_recipes_chat/features/tasks/domain/repos/tasks_repo.dart';

class TasksRepoImpl implements TasksRepo {
  final TasksRemoteDataSource remoteDataSource;

  TasksRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, void>> createTaskList(
      String title, String description) async {
    try {
      await remoteDataSource.createTaskList(title, description);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTaskList(String title) async {
    try {
      await remoteDataSource.deleteTaskList(title);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskList>>> getTaskLists() async {
    try {
      final taskLists = await remoteDataSource.getTaskLists();
      return right(taskLists);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTaskList(TaskList taskList) async {
    try {
      await remoteDataSource.updateTaskList(taskList);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }
}
