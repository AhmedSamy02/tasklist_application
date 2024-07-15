import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tasklist_recipes_chat/core/constants/screens.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/core/errors/server_failure.dart';
import 'package:tasklist_recipes_chat/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/use_cases/login_use_case.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/use_cases/register_use_case.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/use_cases/send_otp_use_case.dart';
import 'package:tasklist_recipes_chat/features/auth/domain/use_cases/verify_otp_use_case.dart';

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
        Navigator.pushReplacementNamed(context, kHomeScreen);
      },
    );
  }

  Future<void> sendOTP({
    required BuildContext context,
    required String email,
    required bool forget,
  }) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Please wait...');
    final useCase = SendOtpUseCase(authRepo: getit.get<AuthRepoImpl>());
    final result = await useCase.call(email, false);
    Navigator.pop(context);
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ServerFailure):
            final message = (failure as ServerFailure).message;
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Server Error',
                text: message);
            break;
          default:
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Unexpected Error',
                text: failure.message);
        }
      },
      (otp) async {
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success',
          text: 'OTP sent to your email, Redirecting...',
          showConfirmBtn: false,
          barrierDismissible: false,
          autoCloseDuration: const Duration(seconds: 3),
        );
        Navigator.pushNamed(context, kOtpScreen, arguments: {
          'email': email,
          'forget': forget,
        });
      },
    );
  }

  Future<void> verifyOtp({
    required BuildContext context,
    required String email,
    required String otp,
    required bool forget,
    required TextEditingController controller,
  }) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Please wait...');
    final useCase = VerifyOtpUseCase(authRepo: getit.get<AuthRepoImpl>());
    final result = await useCase.call(email, otp);
    Navigator.pop(context);
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ServerFailure):
            final message = (failure as ServerFailure).message;
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Server Error',
                text: message);
            break;
          default:
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Unexpected Error',
                text: failure.message);
        }
      },
      (otp) async {
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success',
          text: 'OTP verified, Redirecting...',
          showConfirmBtn: false,
          barrierDismissible: false,
          autoCloseDuration: const Duration(seconds: 3),
        );
        if (forget) {
          Navigator.pushNamed(context, kResetPasswordScreen, arguments: email);
        } else {
          Navigator.pushNamed(context, kRegisterScreen, arguments: email);
        }
      },
    );
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
    required String password,
    required String newPassword,
  }) async {
    final useCase = ResetPasswordUseCase(authRepo: getit.get<AuthRepoImpl>());
    final result = await useCase.call(email, newPassword);
    Navigator.pop(context);
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ServerFailure):
            final message = (failure as ServerFailure).message;
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Server Error',
                text: message);
            break;
          default:
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Unexpected Error',
                text: failure.message);
        }
      },
      (finish) async {
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success',
          text: 'Password reset successful, Redirecting...',
          showConfirmBtn: false,
          barrierDismissible: false,
          autoCloseDuration: const Duration(seconds: 3),
        );
        Navigator.popUntil(context, ModalRoute.withName(kLoginScreen));
      },
    );
  }

  Future<void> register({
    required BuildContext context,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String gender,
  }) async {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Please wait...');
    final useCase = RegisterUseCase(authRepo: getit.get<AuthRepoImpl>());
    final result =
        await useCase.call(firstName, lastName, email, password, gender);
    Navigator.pop(context);
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case const (ServerFailure):
            final message = (failure as ServerFailure).message;
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Server Error',
                text: message);
            break;
          default:
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Unexpected Error',
                text: failure.message);
        }
      },
      (finish) async {
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success',
          text: 'Registration successful, Redirecting...',
          showConfirmBtn: false,
          barrierDismissible: false,
          autoCloseDuration: const Duration(seconds: 3),
        );
        Navigator.popUntil(context, ModalRoute.withName(kLoginScreen));
      },
    );
  }
}
