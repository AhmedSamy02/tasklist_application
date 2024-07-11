import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tasklist_recipes_chat/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/controllers/auth_controller.dart';

void initializeSingletons() {
  getit.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getit.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      remoteDataSource: AuthRemoteDatasourceImpl(
        dio: Dio(),
      ),
    ),
  );
  //! Move it to splash screen after checking if user logged in or not
  getit.registerSingleton(
    AuthController(),
  );
}
