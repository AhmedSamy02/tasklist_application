import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/errors/server_failure.dart';
import 'package:tasklist_recipes_chat/core/errors/unauthorized_failure.dart';
import 'package:tasklist_recipes_chat/core/errors/unknown_failure.dart';
import 'package:tasklist_recipes_chat/features/media/data/data_source/media_remote_data_source.dart';
import 'package:tasklist_recipes_chat/features/media/data/models/media.dart';
import 'package:tasklist_recipes_chat/features/media/domain/repos/media_repo.dart';

class MediaRepoImpl implements MediaRepo {
  final MediaRemoteDataSource mediaRemoteDataSource;

  MediaRepoImpl({required this.mediaRemoteDataSource});
  @override
  Future<Either<Failure, void>> deleteMedia({required String id}) async {
    try {
      await mediaRemoteDataSource.deleteMedia(id: id);
      return right(null);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return left(UnauthorizedFailure(message: 'Unauthorized'));
      }
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Media>>> getMedia(
      {required int page, required int limit}) async {
    try {
      final mediaList =
          await mediaRemoteDataSource.getMedia(page: page, limit: limit);
      return right(mediaList);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return left(UnauthorizedFailure(message: 'Unauthorized'));
      }
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> uploadMedia(
      {required String name, required XFile media}) async {
    try {
      await mediaRemoteDataSource.uploadMedia(name: name, media: media);
      return right(null);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return left(UnauthorizedFailure(message: 'Unauthorized'));
      }
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }
}
