import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';

Future<Response> onRequest(RequestContext context) async {
  if (!checkMethod(context, HttpMethod.post)) {
    return Responses.methodNotAllowed;
  }
  if (context.request.uri.queryParameters['email'] == null ||
      context.request.uri.queryParameters['password'] == null) {
    return badRequestResponse('Email and password are required');
  }
  final email = context.request.uri.queryParameters['email']!;
  final password = context.request.uri.queryParameters['password']!;
  final user = await context.read<Authenticator>().findUserByEmailAndPassword(
    email: email,
    password: password,
  );
  if (user == null) {
    return Responses.unauthorized;
  }
  
  return Response(body: 'Hello World!');
}
