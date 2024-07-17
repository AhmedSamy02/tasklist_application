import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/models/user.dart';
import 'package:tasklist_backend/repositories/media_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final user = context.read<User>();
  final request = context.request;
  switch (request.method) {
    case HttpMethod.get:
      final queryParameters = request.url.queryParameters;
      if (!queryParameters.containsKey('offset') ||
          !queryParameters.containsKey('limit')) {
        return Responses.badRequest;
      }
      final page = int.tryParse(queryParameters['offset'] ?? '0') ?? 0;
      final limit = int.tryParse(queryParameters['limit'] ?? '10') ?? 10;
      final media = await context
          .read<MediaRepository>()
          .getMediaList(userId: user.id, page: page, limit: limit);
      if (media.isEmpty) {
        return Response.json(
          statusCode: 404,
          body: {
            'status_code': 404,
            'message': 'No Media Found',
          },
        );
      }
      return succesResponseWithList('Media Got Successfully', media);
    case HttpMethod.post:
      final formData = await request.formData();
      final files = formData.files;
      if (files.containsKey('media') ||
          files['media'] == null ||
          files.containsKey('name') ||
          files['name'] == null) {
        return Responses.badRequest;
      }
      final media = files['media']!;
      final done = await context.read<MediaRepository>().uploadMedia(
            userId: user.id,
            file: media,
            mediaName: request.url.queryParameters['name']!,
          );
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
    case HttpMethod.delete:
      final mediaId = request.url.queryParameters['id'];
      if (mediaId == null) {
        return Responses.badRequest;
      }
      final done = await context
          .read<MediaRepository>()
          .deleteMedia(mediaId: mediaId);
      if (done) {
        return Response.json(
          body: {
            'status_code': 200,
            'message': 'Media Deleted Successfully',
          },
        );
      } else {
        return Responses.badRequest;
      }
    default:
      return Responses.methodNotAllowed;
  }
}
