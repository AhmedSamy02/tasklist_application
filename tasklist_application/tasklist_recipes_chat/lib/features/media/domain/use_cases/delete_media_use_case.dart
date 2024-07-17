import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/media/domain/repos/media_repo.dart';

class DeleteMediaUseCase extends UseCaseWithOneParam<void,String> {
  final MediaRepo mediaRepo;

  DeleteMediaUseCase(this.mediaRepo);

  @override
  Future<Either<Failure, void>> call(String mediaID) {
    return mediaRepo.deleteMedia(id: mediaID);
  }
}
