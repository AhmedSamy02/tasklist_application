import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/use_cases/use_case_with_params.dart';
import 'package:tasklist_recipes_chat/features/auth/data/models/user.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/repos/auth_repo.dart';

class LoginUseCase extends UseCaseWithTwoParams<User, String, String> {
  final AuthRepo authRepo;

  LoginUseCase({required this.authRepo});

  @override
  Future<Either<Failure, User>> call(String email, String password) {
    return authRepo.login(email, password);
  }
}
