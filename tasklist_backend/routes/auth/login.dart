import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';

Future<Response> onRequest(RequestContext context) async {
  if (!checkMethod(context, HttpMethod.post)) {
    return Responses.methodNotAllowed;
  }
  final request = context.request;
  final body = await request.json();
  if (body is! Map<String, dynamic>) {
    return badRequestResponse('Invalid body');
  }
  if (!body.containsKey('email') ||
      !body.containsKey('password') ||
      body['email'] == null ||
      body['password'] == null ||
      body['email'] == '' ||
      body['password'] == '') {
    return badRequestResponse('Email and password are required');
  }
  final email = body['email'] as String;
  final password = body['password'] as String;
  final user = await context.read<Authenticator>().findUserByEmailAndPassword(
        email: email,
        password: password,
      );
  if (user == null) {
    return badRequestResponse(
      'Invalid email or password',
    );
  }

  return Response.json(
    body: {
      'status_code': 200,
      'message': 'User Logged in successfully',
      'data': user.toJsonWithToken(
        context.read<Authenticator>().generateToken(user: user),
      ),
    },
  );
}
