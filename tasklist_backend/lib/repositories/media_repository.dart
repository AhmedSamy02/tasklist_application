import 'package:cloudinary_api/uploader/uploader.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/values.dart';

class MediaRepository {
  Future<bool> uploadMedia({
    required String userId,
    required UploadedFile file,
    required String mediaName,
  }) async {
    try {
      final collection = getIt.get<DbCollection>(instanceName: 'media');
      final uploader = getIt.get<Uploader>();
      final response = await uploader.upload(file);
      final mediaLink = response!.data!.secureUrl!;
      await collection.insertOne({
        'name': mediaLink,
        'user_id': userId,
        'link': mediaLink,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMedia({
    required String mediaId,
  }) async {
    try {
      final collection = getIt.get<DbCollection>(instanceName: 'media');
      await collection.deleteOne({
        '_id': ObjectId.fromHexString(mediaId),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getMediaList({
    required String userId,
    required int page,
    required int limit,
  }) async {
    final collection = getIt.get<DbCollection>(instanceName: 'media');
    final mediaList = await collection
        .find(
          where.eq('user_id', userId).skip(limit * abs(page)).limit(limit),
        )
        .toList();
    for (final element in mediaList) {
      element['id'] = element['_id'].oid;
      element.remove('_id');
    }
    return mediaList;
  }
}
