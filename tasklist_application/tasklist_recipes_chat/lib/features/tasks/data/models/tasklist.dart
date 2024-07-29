class TaskList {
  String id;
  String title;
  String description;
  int tasksCount;
  TaskList({
    required this.id,
    required this.title,
    required this.description,
    required this.tasksCount,
  });
  factory TaskList.fromJson(Map<String, dynamic> json) {
    return TaskList(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      tasksCount: json['tasks_count'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'tasks_count': tasksCount,
    };
  }
}
