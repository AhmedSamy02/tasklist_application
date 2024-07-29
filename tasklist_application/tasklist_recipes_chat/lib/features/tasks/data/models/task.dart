class Task {
  String id;
  String title;
  String content;
  String listId;
  bool isCompleted;
  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.listId,
    required this.isCompleted,
  });
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      listId: json['listId'] as String,
      isCompleted: json['is_completed'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'listId': listId,
      'is_completed': isCompleted,
    };
  }
}
