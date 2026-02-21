class SetNewTask {
  final String taskName;
  final String taskDescription;

  SetNewTask({required this.taskName, required this.taskDescription});

  Map<String, dynamic> toMap() {
    return {'taskName': taskName, 'taskDescription': taskDescription};
  }

  factory SetNewTask.fromMap(Map<String, dynamic> map) {
    return SetNewTask(
      taskName: map['taskName'] ?? '',
      taskDescription: map['taskDescription'] ?? '',
    );
  }
}
