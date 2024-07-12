import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/models/recipie.dart';

abstract class RecipieRepo {
  Future<Either<Failure,List<Recipie>>>getRecipies({required int page, required int limit});
}