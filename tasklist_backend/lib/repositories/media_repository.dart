import 'package:cloudinary_api/uploader/uploader.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/values.dart';
import 'package:tasklist_backend/models/media.dart';

class MediaRepository {
  Future<bool> uploadMedia({
    required String userId,
    required UploadedFile file,
  }) async {
    try {
      final collection = getIt.get<DbCollection>(instanceName: 'media');
      final uploader = getIt.get<Uploader>();
      final response = await uploader.upload(file);
      final mediaLink = response!.data!.secureUrl!;
      await collection.insertOne({
        'user_id': userId,
        'link': mediaLink,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Media?> getMedia({
    required String userId,
  }) async {
    final collection = getIt.get<DbCollection>(instanceName: 'media');
    final media =
        await collection.modernFindOne(selector: where.eq('user_id', userId));
    if (media == null) {
      return null;
    }
    return Media.fromMap(media);
  }
}
