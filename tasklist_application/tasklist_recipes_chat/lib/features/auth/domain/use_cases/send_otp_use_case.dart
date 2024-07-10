import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/repos/auth_repo.dart';

class SendOtpUseCase extends UseCaseWithOneParam<void, String> {
  final AuthRepo authRepo;

  SendOtpUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> call(String email) {
    return authRepo.sendOTP(email);
  }
}