import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/errors/server_failure.dart';
import 'package:tasklist_recipes_chat/core/errors/unknown_failure.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/data_source/recipies_remote_data_source.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/models/recipie.dart';
import 'package:tasklist_recipes_chat/features/recipies/domain/repos/recipie_repo.dart';

class RecipieRepoImpl implements RecipieRepo {
  final RecipiesRemoteDataSource recipiesRemoteDataSource;

  RecipieRepoImpl({required this.recipiesRemoteDataSource});
  @override
  Future<Either<Failure, List<Recipie>>> getRecipies(
      {required int page, required int limit}) async {
    try {
      final recipies =
          await recipiesRemoteDataSource.getRecipies(page: page, limit: limit);
      return right(recipies);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }
}
