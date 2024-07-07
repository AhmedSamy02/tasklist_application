import 'package:dart_frog/dart_frog.dart';
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
  final sent = await context.read<Authenticator>().generateOTP(email);
  return Response.json(
    body: sent.data,
  );
}
