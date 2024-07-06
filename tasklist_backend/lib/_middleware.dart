import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';

//This middleware is used to provide Authenticator to all routes as it will be used in different routes
Handler middleware(Handler handler) {
  return handler.use(
    provider<Authenticator>(
      (_) => Authenticator(),
    ),
  );
}
