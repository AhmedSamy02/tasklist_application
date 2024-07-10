import 'package:dartz/dartz.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/features/auth/data/models/user.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, void>> register(String firstName, String lastName,
      String gender, String email, String password);
  Future<Either<Failure, void>> resetPassword(String email, String newPassword);
  Future<Either<Failure, void>> sendOTP(String email);
  Future<Either<Failure, void>> verifyOTP(String email, String otp);
}
