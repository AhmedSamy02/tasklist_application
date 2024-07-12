import 'package:dio/dio.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/auth/data/models/user.dart';

abstract class AuthRemoteDatasource {
  Future<User> login(String email, String password);
  Future<void> register(String firstName, String lastName, String gender,
      String email, String password);
  Future<void> resetPassword(String email, String newPassword);
  Future<void> sendOTP(String email, bool forget);
  Future<void> verifyOTP(String email, String otp);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;
  final endpoint = 'auth/';
  AuthRemoteDatasourceImpl({required this.dio});
  @override
  Future<User> login(String email, String password) async {
    final response = await dio.post('$baseURL${endpoint}login',
        data: {'email': email, 'password': password});
    return User.fromJson(response.data['data']);
  }

  @override
  Future<void> register(String firstName, String lastName, String gender,
      String email, String password) async {
    await dio.post('$baseURL${endpoint}signup', data: {
      'email': email,
      'password': password,
      'gender': gender,
      'first_name': firstName,
      'last_name': lastName
    });
  }

  @override
  Future<void> sendOTP(String email, bool forget) async {
    await dio.post('$baseURL${endpoint}sendotp',
        queryParameters: {'email': email, 'forget': forget ? 'true' : 'false'});
  }

  @override
  Future<void> verifyOTP(String email, String otp) async {
    await dio.post('$baseURL${endpoint}verifyotp',
        queryParameters: {'email': email, 'otp': otp});
  }

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    await dio.post('$baseURL${endpoint}reset',
        data: {'email': email, 'password': newPassword});
  }
}
