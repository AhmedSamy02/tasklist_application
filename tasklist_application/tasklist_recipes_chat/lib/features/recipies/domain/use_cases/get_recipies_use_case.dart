import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/models/recipie.dart';
import 'package:tasklist_recipes_chat/features/recipies/domain/repos/recipie_repo.dart';

class GetRecipiesUseCase extends UseCaseWithTwoParams<List<Recipie>,int,int>{
  final RecipieRepo recipieRepo;

  GetRecipiesUseCase({required this.recipieRepo});
  @override
  Future<Either<Failure, List<Recipie>>> call(int page, int limit) {
    return recipieRepo.getRecipies(page: page, limit: limit);
  }
  
}