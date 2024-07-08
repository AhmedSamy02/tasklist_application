import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:tasklist_backend/constants/values.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      logger.d('Connected to WebSocket channel: $channel');
      channel.stream.listen((message) {
        logger.d('Received message: $message');
        channel.sink.add(message);
      });
    },
  );

  return handler(context);
}
