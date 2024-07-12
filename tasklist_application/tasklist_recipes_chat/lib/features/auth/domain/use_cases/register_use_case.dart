import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/repos/auth_repo.dart';

class RegisterUseCase extends UseCaseWithFiveParams<void, String, String,
    String, String, String> {
  final AuthRepo authRepo;

  RegisterUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> call(
    String firstName,
    String lastName,
    String email,
    String password,
    String gender,
  ) {
    return authRepo.register(firstName, lastName, gender, email, password);
  }
}
