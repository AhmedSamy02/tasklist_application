import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/media/data/models/media.dart';
import 'package:tasklist_recipes_chat/features/media/domain/repos/media_repo.dart';

class GetMediaUseCase extends UseCaseWithTwoParams<List<Media>, int,int> {
  final MediaRepo mediaRepo;

  GetMediaUseCase({required this.mediaRepo});

  @override
  Future<Either<Failure, List<Media>>> call(int page, int limit) {
    return mediaRepo.getMedia(page: page, limit: limit);
  }
}