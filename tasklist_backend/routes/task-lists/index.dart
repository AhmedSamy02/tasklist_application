import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/models/user.dart';
import 'package:tasklist_backend/repositories/tasklist_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final user = context.read<User>();
  final userId = user.id;
  final request = context.request;
  final body = await request.json() as Map<String, dynamic>;
  switch (context.request.method) {
    case HttpMethod.get:
      return Responses.notImplemented;
    case HttpMethod.put:
      if (!body.containsKey('title') ||
          !body.containsKey('description') ||
          body['title'] == null ||
          body['description'] == null ||
          body['title'] is! String ||
          body['description'] is! String) {
        return Response.json(
          body: {
            'status_code': 400,
            'message': 'Title and description are required',
          },
          statusCode: 400,
        );
      }
      final title = body['title'] as String;
      final description = body['description'] as String;
      if (title.isEmpty || description.isEmpty) {
        return Response.json(
          body: {
            'status_code': 400,
            'message': 'Title or description cannot be empty',
          },
          statusCode: 400,
        );
      }
      final taskListExist = await context
          .read<TasklistRepository>()
          .checkTaskListExist(userId: userId, title: title);
          if(taskListExist){
            return Response.json(
              body: {
                'status_code': 400,
                'message': 'Task List with this title already exist',
              },
              statusCode: 400,
            );
          }
      final taskList = await context.read<TasklistRepository>().createTasklist(
            userId: userId,
            title: title,
            description: description,
          );
      return successResponse(
        'Task List is created succesfully',
        taskList.toMap(),
      );
    case HttpMethod.delete:
      return Responses.notImplemented;
    default:
      return Responses.methodNotAllowed;
  }
}
