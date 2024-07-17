import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/media/domain/repos/media_repo.dart';

class UploadMediaUseCase extends UseCaseWithTwoParams<void, String, XFile> {
  final MediaRepo mediaRepo;

  UploadMediaUseCase({required this.mediaRepo});

  @override
  Future<Either<Failure, void>> call(String name, XFile media) {
    return mediaRepo.uploadMedia(name: name, media: media);
  }
}
