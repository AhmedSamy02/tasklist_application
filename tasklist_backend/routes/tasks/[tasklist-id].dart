import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/repositories/task_repository.dart';

Future<Response> onRequest(RequestContext context, String tasklistId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllTasks(context, tasklistId);
    case HttpMethod.delete:
      return _deleteTask(context, tasklistId);
    case HttpMethod.post:
      return _createTask(context, tasklistId);
    case HttpMethod.put:
      return _updateTask(context, tasklistId);
    default:
      return Responses.methodNotAllowed;
  }
}

Future<Response> _getAllTasks(RequestContext context, String tasklistId) async {
  final tasks = await context.read<TaskRepository>().getTasks(tasklistId);
  return Response.json(
    body: {
      'status_code': 200,
      'message': 'Tasks are fetched successfully',
      'data': tasks.map((e) => e.toMap()).toList(),
    },
  );
}

Future<Response> _updateTask(RequestContext context, String tasklistId) async {
  final body = await context.request.json() as Map<String, dynamic>;
  if (!checkKeyFoundOrEmpty(body, 'title')) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Title is required',
      },
      statusCode: 400,
    );
  }
  if (!checkKeyFoundOrEmpty(body, 'content')) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Content is required',
      },
      statusCode: 400,
    );
  }
  if (!checkKeyFoundOrEmpty(body, 'is_completed')) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'is_completed is required',
      },
      statusCode: 400,
    );
  }
  if (!checkKeyFoundOrEmpty(body, 'task_id')) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'task_id is required',
      },
      statusCode: 400,
    );
  }
  final task = await context.read<TaskRepository>().updateTask(
        listId: tasklistId,
        taskId: body['task_id'] as String,
        title: body['title'] as String,
        content: body['content'] as String,
        isCompleted: body['is_completed'] as bool,
      );
  if (!task) {
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
      'message': 'Task is updated successfully',
    },
  );
}

Future<Response> _createTask(RequestContext context, String tasklistId) async {
  final body = await context.request.json() as Map<String, dynamic>;
  if (!checkKeyFoundOrEmpty(body, 'title')) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Title is required',
      },
      statusCode: 400,
    );
  }
  if (!checkKeyFoundOrEmpty(body, 'content')) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Content is required',
      },
      statusCode: 400,
    );
  }
  final task = await context.read<TaskRepository>().addTask(
        listId: tasklistId,
        title: body['title'] as String,
        content: body['content'] as String,
      );
  return Response.json(
    body: {
      'status_code': 200,
      'message': 'Task is added successfully',
      'data': task.toMap(),
    },
  );
}

Future<Response> _deleteTask(RequestContext context, String tasklistId) async {
  final body = await context.request.json() as Map<String, dynamic>;
  if (!checkKeyFoundOrEmpty(body, 'title')) {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Title is required',
      },
      statusCode: 400,
    );
  }
  if (await context
      .read<TaskRepository>()
      .deleteTask(listId: tasklistId, title: body['title'] as String)) {
    return Response.json(
      body: {
        'status_code': 200,
        'message': 'Task is deleted successfully',
      },
    );
  } else {
    return Response.json(
      body: {
        'status_code': 400,
        'message': 'Task is not found',
      },
      statusCode: 400,
    );
  }
}
