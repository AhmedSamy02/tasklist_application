import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/repositories/task_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final queryParameters = context.request.uri.queryParameters;
  if (!checkKeyFoundOrEmpty(queryParameters, 'id')) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Task ID is required',
      },
      statusCode: 400,
    );
  }
  final taskId = queryParameters['id']!;
  final done =
      await context.read<TaskRepository>().uncompleteTask(taskId: taskId);
  if (!done) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Task is not found',
      },
      statusCode: 400,
    );
  }
  return Response.json(
    body: {
      'status_code': 200,
      'message': 'Task is marked as uncompleted successfully',
    },
  );
}
