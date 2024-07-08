import 'package:mongo_dart/mongo_dart.dart';

class TaskList {

  TaskList({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.tasksCount,
  });
  factory TaskList.fromMap(Map<String, dynamic> map) {
    return TaskList(
      id: map['_id'] as ObjectId,
      userId: map['user_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      tasksCount: map['tasks_count'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id!.oid,
      'user_id': userId,
      'title': title,
      'description': description,
      'tasks_count': tasksCount,
    };
  }
  ObjectId? id;
  String? userId;
  String? title;
  String? description;
  int? tasksCount;
}
