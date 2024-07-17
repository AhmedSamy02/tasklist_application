import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/features/media/data/models/media.dart';

abstract class MediaRepo {
  Future<Either<Failure, List<Media>>> getMedia(
      {required int page, required int limit});
  Future<Either<Failure, void>> deleteMedia({required String id});
  Future<Either<Failure, void>> uploadMedia(
      {required String name, required XFile media});
}
