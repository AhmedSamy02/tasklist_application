import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/media/data/models/media.dart';

abstract class MediaRemoteDataSource {
  Future<List<Media>> getMedia({required int page, required int limit});
  Future<void> deleteMedia({required String id});
  Future<void> uploadMedia({required String name, required XFile media});
}

class MediaRemoteDataSourceImpl implements MediaRemoteDataSource {
  final String endpoint = 'media/';
  final Dio dio;

  MediaRemoteDataSourceImpl({required this.dio});
  @override
  Future<void> deleteMedia({required String id}) async {}

  @override
  Future<List<Media>> getMedia({required int page, required int limit}) async {
    final token = await getit.get<FlutterSecureStorage>().read(key: 'token');
    final response = await getit.get<Dio>().get(
          '$baseURL$endpoint',
          queryParameters: {'offset': page, 'limit': limit},
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
    final media = response.data['data'] as List<Map<String, dynamic>>;
    return media.map((e) => Media.fromJson(e)).toList();
  }

  @override
  Future<void> uploadMedia({required String name, required XFile media}) async {
    final token = await getit.get<FlutterSecureStorage>().read(key: 'token');
    final formData = FormData.fromMap({
      'name': name,
      'media': await MultipartFile.fromFile(media.path),
    });
    await dio.post('$baseURL$endpoint',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
  }
}
