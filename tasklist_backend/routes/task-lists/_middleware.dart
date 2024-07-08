// routes/admin/_middleware.dart
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:tasklist_backend/models/user.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';
import 'package:tasklist_backend/repositories/tasklist_repository.dart';

Handler middleware(Handler handler) {
  return handler
      .use(
    provider(
      (_) => TasklistRepository(),
    ),
  )
      .use(
    bearerAuthentication<User>(
      authenticator: (context, token) {
        return context.read<Authenticator>().verifyToken(token);
      },
    ),
  );
}
