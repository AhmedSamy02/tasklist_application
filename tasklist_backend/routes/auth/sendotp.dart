import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
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
  if (!checkEmailAcceptance(email)) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': "Email isn't valid",
      },
      statusCode: 400,
    );
  }
  if (await context.read<Authenticator>().findUserByEmail(email) == null) {
    return Response.json(
      body: {
        'status_code': 404,
        'message': "Email isn't registered",
      },
      statusCode: 404,
    );
  }
  final sent = await context.read<Authenticator>().generateOTP(email);
  return Response.json(
    body: sent.data,
  );
}
