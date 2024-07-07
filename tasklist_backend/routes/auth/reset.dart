import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/constants/values.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';

Future<Response> onRequest(RequestContext context) async {
  final body = await context.request.json();
  if (body is! Map<String, dynamic>) {
    return Responses.badRequest;
  }
  if (!body.containsKey('email') || body['email'] == null) {
    return Responses.badRequest;
  }
  if (!body.containsKey('password') || body['password'] == null) {
    return Responses.badRequest;
  }
  final email = body['email'] as String;
  if (!checkEmailAcceptance(email)) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': "Email isn't valid",
      },
      statusCode: 400,
    );
  }
  final password = body['password'] as String;
  if (await getIt.get<Authenticator>().findUserByEmail(email) == null) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': "Email isn't found",
      },
      statusCode: 400,
    );
  }
  if (!checkPasswordAcceptance(password)) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': "Password isn't valid",
      },
      statusCode: 400,
    );
  }
  final reset = await getIt.get<Authenticator>().resetPassword(email, password);
  if (reset == false) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': "Email or password isn't valid",
      },
      statusCode: 400,
    );
  } else {
    return Response.json(
      body: {
        'status_code': 200,
        'message': 'Password reset successfully',
      },
    );
  }
}
