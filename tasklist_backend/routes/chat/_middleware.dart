import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:tasklist_backend/models/user.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';

Handler middleware(Handler handler) {
  return handler
      .use(
    bearerAuthentication<User>(
      authenticator: (context, token) {
        return context.read<Authenticator>().verifyToken(token);
      },
    ),
  );
}
