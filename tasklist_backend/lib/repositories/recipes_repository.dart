import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/values.dart';

class RecipesRepository {
  Future<List<Map<String, dynamic>>> getRecipies(int page, int limit) async {
    final data = await getIt
        .get<DbCollection>(instanceName: 'recipes')
        .find(where.skip(limit * abs(page)).limit(limit))
        .toList();
    for (final element in data) {
      element['id'] = element['_id'].oid;
      element.remove('_id');
    }
    return data;
  }

  Future<List<Map<String, dynamic>>> filterRecipies({
    required int page,
    required int limit,
    String? cuisine,
    String? course,
    String? diet,
    int? prepTime,
    int? cookTime,
  }) async {
    final data = await getIt
        .get<DbCollection>(instanceName: 'recipes')
        .find(
          where
              .eq('cuisine', cuisine)
              .eq('course', course)
              .eq('diet', diet)
              .inRange(
                'prep_time (in mins)',
                prepTime != null
                    ? prepTime > 5
                        ? prepTime - 5
                        : 0
                    : 0,
                prepTime != null
                    ? prepTime < 5
                        ? 10
                        : prepTime + 5
                    : 1000,
              )
              .inRange(
                'cook_time (in mins)',
                cookTime != null
                    ? cookTime > 5
                        ? cookTime - 5
                        : 0
                    : 0,
                cookTime != null
                    ? cookTime < 5
                        ? 10
                        : cookTime + 5
                    : 1000,
              )
              .skip(limit * abs(page))
              .limit(limit),
        )
        .toList();
    for (final element in data) {
      element['id'] = element['_id'].oid;
      element.remove('_id');
    }
    return data;
  }

  Future<Map<String, dynamic>> getFilters() async {
    final cuisine = await getIt
        .get<DbCollection>(instanceName: 'recipes')
        .distinct('cuisine');
    final course = await getIt
        .get<DbCollection>(instanceName: 'recipes')
        .distinct('course');
    final diet =
        await getIt.get<DbCollection>(instanceName: 'recipes').distinct('diet');
        
    return {
      'cuisine': cuisine['values'],
      'course': course['values'],
      'diet': diet['values'],

    };
  }
}
