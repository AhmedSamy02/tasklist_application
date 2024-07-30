import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/models/user.dart';
import 'package:tasklist_backend/repositories/tasklist_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final user = context.read<User>();
  final userId = user.id;
  final request = context.request;
  switch (request.method) {
    case HttpMethod.get:
      return Response.json(
        body: {
          'status_code': 200,
          'message': 'Task Lists are fetched successfully',
          'data': await context.read<TasklistRepository>().getTasklists(userId),
        },
      );
    case HttpMethod.put:
      final body = await request.json() as Map<String, dynamic>;
      return _handlePutRequest(body, context, userId);
    case HttpMethod.post:
      final body = await request.json() as Map<String, dynamic>;
      return _handlePostRequest(body, context, userId);
    case HttpMethod.delete:
      final body = await request.json() as Map<String, dynamic>;
      if (!body.containsKey('title') ||
          body['title'] == null ||
          body['title'] is! String) {
        return Response.json(
          body: {
            'status_code': 400,
            'message': 'Title is required',
          },
          statusCode: 400,
        );
      }
      final title = body['title'] as String;
      if (title.isEmpty ||
          !await context
              .read<TasklistRepository>()
              .deleteTaskList(userId, title)) {
        return badRequestResponse('Task List is not found');
      }
      return Response.json(
        body: {
          'status_code': 200,
          'message': 'Task List is deleted successfully',
        },
      );
    default:
      return Responses.methodNotAllowed;
  }
}

Future<Response> _handlePostRequest(
  Map<String, dynamic> body,
  RequestContext context,
  String userId,
) async {
  if (!body.containsKey('id') || body['id'] == null || body['id'] is! String) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'ID must be provided',
      },
      statusCode: 400,
    );
  }
  final id = body['id'] as String;
  if (id.isEmpty) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'ID cannot be empty',
      },
      statusCode: 400,
    );
  }
  String? title;
  String? description;
  if(!body.containsKey('title')){
    title = null;
  }
  if (body.containsKey('title') &&
      (body['title'] == null || body['title'] is! String)) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': "Title can't be null",
      },
      statusCode: 400,
    );
  }
  if(!body.containsKey('description')){
    description = null;
  }
  if (body.containsKey('description') &&
      (body['description'] == null || body['description'] is! String)) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': "Description can't be null",
      },
      statusCode: 400,
    );
  }
  if(title==null&& description==null){
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Title or description must be provided',
      },
      statusCode: 400,
    );
  }
  await context
      .read<TasklistRepository>()
      .updateTasklist(id: id, userId: userId, title: title, description: description);
      return Response.json(
        body: {
          'status_code': 200,
          'message': 'Task List is updated successfully',
        },
      );
}

Future<Response> _handlePutRequest(
  Map<String, dynamic> body,
  RequestContext context,
  String userId,
) async {
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
  if (taskListExist) {
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
}
