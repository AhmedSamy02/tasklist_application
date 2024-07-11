import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/core/errors/server_failure.dart';
import 'package:tasklist_recipes_chat/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/use_cases/login_use_case.dart';

class AuthController {
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Please wait...');

    final useCase = LoginUseCase(authRepo: getit.get<AuthRepoImpl>());
    final result = await useCase(email, password);

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ServerFailure):
            Navigator.pop(context);
            final message = (failure as ServerFailure).message;
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: message);
            break;
          default:
            Navigator.pop(context);
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: failure.message);
        }
      },
      (user) async {
        final storage = getit.get<FlutterSecureStorage>();
        await storage.write(key: 'logged In', value: 'true');
        await storage.write(key: 'token', value: user.token);
        await storage.write(key: 'email', value: user.email);
        await storage.write(key: 'gender', value: user.gender);
        await storage.write(key: 'last_name', value: user.lastName);
        await storage.write(key: 'first_name', value: user.firstName);
        await storage.write(key: 'id', value: user.id);
        Navigator.pop(context);
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success',
          text: 'Login successful',
        );
        // Navigator.pushNamed(context, kHomeScreen);
      },
    );
  }
}
