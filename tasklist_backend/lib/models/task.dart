import 'package:mongo_dart/mongo_dart.dart';

class Task {
  Task({
    required this.id,
    required this.listId,
    required this.title,
    required this.content,
    required this.isCompleted,
  });
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['_id'] as ObjectId,
      listId: map['list_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      isCompleted: map['is_completed'] as bool,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id.oid,
      'list_id': listId,
      'title': title,
      'content': content,
      'is_completed': isCompleted,
    };
  }

  final ObjectId id;
  final String listId;
  final String title;
  final String content;
  final bool isCompleted;
}
