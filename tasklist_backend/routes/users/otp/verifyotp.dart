import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';

Response onRequest(RequestContext context) {
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
  final verified = context.read<Authenticator>().verifyOTP(email, otp);
  return Response.json(
    body: verified,
  );
}
