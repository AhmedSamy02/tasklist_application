import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/models/recipie.dart';

abstract class RecipiesRemoteDataSource {
  Future<List<Recipie>> getRecipies({required int page, required int limit});
}

class RecipiesRemoteDataSourceImpl implements RecipiesRemoteDataSource {
  final Dio dio;
  final endpoint = 'recipes/';
  RecipiesRemoteDataSourceImpl({required this.dio});
  @override
  Future<List<Recipie>> getRecipies(
      {required int page, required int limit}) async {
    final token = await getit.get<FlutterSecureStorage>().read(key: 'token');
    final response = await dio.get('$baseURL$endpoint',
        queryParameters: {'offset': page, 'limit': limit},
        options: Options(headers: {'Authorization': 'Bearer $token'}));
        
        final recipies = response.data['data'] as List<dynamic>;
    return recipies.map((e) => Recipie.fromJson(e)).toList();
  }
}
