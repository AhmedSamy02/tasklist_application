import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/values.dart';
import 'package:tasklist_backend/models/task.dart';

class TaskRepository {
  Future<List<Task>> getTasks(String listId) async {
    final collection = getIt.get<DbCollection>(instanceName: 'tasks');
    final tasks = await collection.find(where.eq('list_id', listId)).toList();
    return tasks.map(
      (e) {
        return Task.fromMap(e);
      },
    ).toList();
  }

  Future<Task> addTask(
      {required String listId,
      required String title,
      required String content}) async {
    final collection = getIt.get<DbCollection>(instanceName: 'tasks');
    final write = await collection.insertOne({
      'list_id': listId,
      'title': title,
      'content': content,
      'is_completed': false,
    });
    final task = write.document;
    return Task.fromMap(task!);
  }

  Future<bool> deleteTask({
    required String listId,
    required String title,
  }) async {
    final task = await getIt
        .get<DbCollection>(instanceName: 'tasks')
        .findOne(where.eq('list_id', listId).eq('title', title));
    if (task == null) {
      return false;
    }
    await getIt
        .get<DbCollection>(instanceName: 'tasks')
        .remove(where.eq('list_id', listId).eq('title', title));
    return true;
  }

  Future<bool> updateTask({
    required String listId,
    required String taskId,
    required String title,
    required String content,
    required bool isCompleted,
  }) async {
    final task = await getIt.get<DbCollection>(instanceName: 'tasks').findOne(
        where.eq('list_id', listId).eq('_id', ObjectId.fromHexString(taskId)));
    if (task == null) {
      return false;
    }
    await getIt.get<DbCollection>(instanceName: 'tasks').update(
          where.eq('list_id', listId).eq('_id', ObjectId.fromHexString(taskId)),
          modify
              .set('title', title)
              .set('content', content)
              .set('is_completed', isCompleted),
        );
    return true;
  }

  Future<bool> completeTask({
    required String taskId,
  }) async {
    final task = await getIt.get<DbCollection>(instanceName: 'tasks').findOne(
          where.eq('_id', ObjectId.fromHexString(taskId)),
        );
    if (task == null) {
      return false;
    }
    await getIt.get<DbCollection>(instanceName: 'tasks').update(
          where.eq('_id', ObjectId.fromHexString(taskId)),
          modify.set('is_completed', true),
        );
    return true;
  }

  Future<bool> uncompleteTask({
    required String taskId,
  }) async {
    final task = await getIt.get<DbCollection>(instanceName: 'tasks').findOne(
          where.eq('_id', ObjectId.fromHexString(taskId)),
        );
    if (task == null) {
      return false;
    }
    await getIt.get<DbCollection>(instanceName: 'tasks').update(
          where.eq('_id', ObjectId.fromHexString(taskId)),
          modify.set('is_completed', false),
        );
    return true;
  }
}
