import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';

Future<Response> onRequest(RequestContext context) async {
  var body = await context.request.json();
  if (body is! Map<String, dynamic>) {
    return Responses.badRequest;
  }
  if (!checkSignupDataProvided(body)) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Form Data is not valid',
      },
      statusCode: 400,
    );
  }
  if (!checkEmailAcceptance(body['email'] as String)) {
    return badRequestResponse('The email provided is not valid');
  }
  if (!checkPasswordAcceptance(body['password'] as String)) {
    return badRequestResponse('The password provided is not valid');
  }
  if (!checkGender(body['gender'] as String)) {
    return badRequestResponse('The gender provided is not valid');
  }
  await context.read<Authenticator>().createUser(
        email: body['email'] as String,
        password: body['password'] as String,
        firstName: body['first_name'] as String,
        lastName: body['last_name'] as String,
        gender: body['gender'] as String,
      );
  return Response.json(
    body: {
      'status_code': 200,
      'message': 'User created successfully',
    },
  );
}
