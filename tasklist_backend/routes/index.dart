import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response.json(
    body: {
      'status_code': 200,
      'message': 'Welcome to Tasklist Application Backend',
    },
  );
}
