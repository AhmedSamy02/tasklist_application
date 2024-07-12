import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasklist_recipes_chat/core/errors/failure.dart';
import 'package:tasklist_recipes_chat/core/errors/server_failure.dart';
import 'package:tasklist_recipes_chat/core/errors/unknown_failure.dart';
import 'package:tasklist_recipes_chat/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tasklist_recipes_chat/features/auth/data/models/user.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource remoteDataSource;

  AuthRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return right(user);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> register(String firstName, String lastName,
      String gender, String email, String password) async {
    try {
      await remoteDataSource.register(
          firstName, lastName, gender, email, password);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      String email, String newPassword) async {
    try {
      await remoteDataSource.resetPassword(email, newPassword);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendOTP(String email, bool forget) async {
    try {
      await remoteDataSource.sendOTP(email, forget);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOTP(String email, String otp) async {
    try {
      await remoteDataSource.verifyOTP(email, otp);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDio(e));
    } catch (e) {
      return left(UnknownFailure(message: e.toString()));
    }
  }
}
