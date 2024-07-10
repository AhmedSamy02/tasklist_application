import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/repos/auth_repo.dart';

class ResetPasswordUseCase extends UseCaseWithTwoParams<void, String, String> {
  final AuthRepo authRepo;

  ResetPasswordUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> call(String email, String newPassword) {
    return authRepo.resetPassword(email, newPassword);
  }
}
