class SetNewTask {
  final String taskName;
  final String taskDescription;
  bool isDone = false;

  SetNewTask({
    required this.taskName,
    required this.taskDescription,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isDone': isDone,
    };
  }

  factory SetNewTask.fromMap(Map<String, dynamic> map) {
    return SetNewTask(
      taskName: map['taskName'] ?? '',
      taskDescription: map['taskDescription'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }
}
