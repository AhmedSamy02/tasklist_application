import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/values.dart';
import 'package:tasklist_backend/models/task_list.dart';

class TasklistRepository {
  Future<TaskList> createTasklist({
    required String userId,
    required String title,
    required String description,
  }) async {
    final write =
        await getIt.get<DbCollection>(instanceName: 'task_lists').insertOne({
      'user_id': userId,
      'title': title,
      'description': description,
      'tasks_count': 0,
    });
    final taskList = write.document;
    return TaskList.fromMap(taskList!);
  }

  Future<List<TaskList>> getTasklists(String userId) async {
    final taskLists = await getIt
        .get<DbCollection>(instanceName: 'task_lists')
        .find(where.eq('user_id', userId))
        .toList();
    return taskLists.map((e) => TaskList.fromMap(e)).toList();
  }

  Future<bool> checkTaskListExist(
      {required String userId, required String title}) async {
    final taskList = await getIt
        .get<DbCollection>(instanceName: 'task_lists')
        .findOne(where.eq('user_id', userId).eq('title', title));
    return taskList != null;
  }
}
