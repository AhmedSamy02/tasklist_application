import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tasklist_recipes_chat/core/constants/screens.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tasklist_recipes_chat/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:tasklist_recipes_chat/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/data_source/recipies_remote_data_source.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/repositories/recipie_repo_impl.dart';
import 'package:tasklist_recipes_chat/features/recipies/domain/use_cases/get_recipies_use_case.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/controllers/recipies_controller.dart';

void initializeSingletons() {
  getit.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getit.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      remoteDataSource: AuthRemoteDatasourceImpl(
        dio: Dio(),
      ),
    ),
  );
  getit.registerSingleton<RecipiesController>(
    RecipiesController(
      getRecipiesUseCase: GetRecipiesUseCase(
        recipieRepo: RecipieRepoImpl(
          recipiesRemoteDataSource: RecipiesRemoteDataSourceImpl(
            dio: Dio(),
          ),
        ),
      ),
    ),
  );
  //! Move it to splash screen after checking if user logged in or not
  getit.registerSingleton(
    AuthController(),
  );
}

Future<void> checkToken({required BuildContext context}) async {
  await QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: 'Unauthorized',
    text: 'Your token has expired, please login again',
    autoCloseDuration: const Duration(seconds: 5),
  );
  final secure = getit.get<FlutterSecureStorage>();
  await secure.deleteAll();
  await secure.write(key: 'logged In', value: 'false');
  Navigator.of(context).pushNamedAndRemoveUntil(
    kLoginScreen,
    (route) => false,
  );
}
