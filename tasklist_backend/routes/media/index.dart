import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/models/user.dart';
import 'package:tasklist_backend/repositories/media_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final user = context.read<User>();
  final request = context.request;
  switch (request.method) {
    case HttpMethod.get:
      final media =
          await context.read<MediaRepository>().getMedia(userId: user.id);
      if (media == null) {
        return Responses.notFound;
      }
      return Response.json(
        body: {
          'status_code': 200,
          'message': 'Media Got Successfully',
          'data': media.toMap(),
        },
      );
    case HttpMethod.post:
      final formData = await request.formData();
      final files = formData.files;
      if (files.containsKey('media') || files['media'] == null) {
        return Responses.badRequest;
      }
      final media = files['media']!;
      final done = await context
          .read<MediaRepository>()
          .uploadMedia(userId: user.id, file: media);
      if (done) {
        return Response.json(
          body: {
            'status_code': 200,
            'message': 'Media Uploaded Successfully',
          },
        );
      } else {
        return Responses.badRequest;
      }
    default:
      return Responses.methodNotAllowed;
  }
}
