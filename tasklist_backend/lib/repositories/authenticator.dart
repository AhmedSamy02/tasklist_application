import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/values.dart';
import 'package:tasklist_backend/models/user.dart';

class Authenticator {
  Future<User?> findUserByEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCollection = getIt.get<DbCollection>(instanceName: 'users');
    return userCollection
        .findOne(where.eq('email', email).eq('password', password))
        .then((value) => value != null ? User.fromMap(value) : null);
  }

  String generateToken({
    required User user,
  }) {
    final jwt = JWT(
      {
        'id': user.id,
        'email': user.email,
        'first_name': user.firstName,
        'last_name': user.lastName,
      },
      issuer: 'tasklist_backend',
      subject: 'auth',
    );
    return jwt.sign(
      SecretKey(secretKey),
      expiresIn: const Duration(days: 1),
    );
  }

  Future<User?> verifyToken(String token) async {
    final jwt = JWT.verify(token, SecretKey(secretKey));
    return getIt
        .get<DbCollection>(instanceName: 'users')
        .findOne(
          where.id(ObjectId.fromHexString(jwt.payload['id'] as String)),
        )
        .then((value) => value != null ? User.fromMap(value) : null);
  }

  Future<Response> generateOTP(String email) async {
      final response = await getIt.get<Dio>().post(
        'https://otp-service-beta.vercel.app/api/otp/generate',
        data: {
          'email': email,
          'type': 'alphanumeric',
          'organization': 'Tasklist App',
          'subject': 'OTP Verification'
        },
      );
      return response;
  }
  Future<Response> verifyOTP(String email, String otp) async {
      final response = await getIt.get<Dio>().post(
        'https://otp-service-beta.vercel.app/api/otp/verify',
        data: {
          'email': email,
          'otp': otp,
        },
      );
      return response;
    
  }
}
