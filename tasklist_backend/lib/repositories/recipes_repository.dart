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
      final id = element['_id'] as ObjectId;
      element['_id'] = id.oid;
    }
    return data;
  }
}
