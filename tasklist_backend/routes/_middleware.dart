import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/repositories/authenticator.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
        provider<Authenticator>(
          (_) => Authenticator(),
        ),
      );
}
