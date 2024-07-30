import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/tasks/data/models/tasklist.dart';

abstract class TasksRemoteDataSource {
  Future<void> createTaskList(String title, String description);
  Future<void> updateTaskList(TaskList taskList);
  Future<void> deleteTaskList(String title);
  Future<List<TaskList>> getTaskLists();
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final String listsEndpoint = 'task-lists/';
  final String tasksEndpoint = 'tasks/';
  final Dio dio;

  TasksRemoteDataSourceImpl({required this.dio});

  @override
  Future<void> createTaskList(String title, String description) async {
    final token = await getit.get<FlutterSecureStorage>().read(key: 'token');
    await dio.put(
      '$baseURL$listsEndpoint',
      data: {
        'title': title,
        'description': description,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<void> deleteTaskList(String title) async {
    final token = await getit.get<FlutterSecureStorage>().read(key: 'token');
    await dio.put(
      '$baseURL$listsEndpoint',
      data: {
        'title': title,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<List<TaskList>> getTaskLists() async {
    final token = await getit.get<FlutterSecureStorage>().read(key: 'token');
    final response = await dio.get(
      '$baseURL$listsEndpoint',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return (response.data['data'] as List)
        .map((e) => TaskList.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> updateTaskList(TaskList taskList) async {
    // TODO: implement updateTaskList
    throw UnimplementedError();
  }
}
