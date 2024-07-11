import 'package:dart_frog/dart_frog.dart';
import 'package:dio/dio.dart' as dio;
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/constants/values.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';

Future<Response> onRequest(RequestContext context) async {
  final email = context.request.uri.queryParameters['email'];
  if (email == null || email.isEmpty) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Email is required',
      },
      statusCode: 400,
    );
  }
  final otp = context.request.uri.queryParameters['otp'];
  if (otp == null || otp.isEmpty) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'OTP is required',
      },
      statusCode: 400,
    );
  }
  try {
    final verified = await context.read<Authenticator>().verifyOTP(email, otp);
    return Response.json(
      body: verified.data,
    );
  } on dio.DioException catch (e) {
    final response = e.response;
    logger.e('Dio Exception :- ${response?.data['error']}');
    return Response.json(
      body: {
        'status_code': response?.statusCode??400,
        'message': response?.data['error'],
      },
      statusCode: response?.statusCode ?? 400,
    );
  } catch (e) {
    logger.e('Internal Server Error :- $e');
    return Responses.internalServerError;
  }
}
