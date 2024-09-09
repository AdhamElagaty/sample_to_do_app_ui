class SubTaskModel {
  int? id;
  String title;
  bool isCompleted;
  int? taskId; // Foreign key reference to Task

  SubTaskModel({
    this.id,
    required this.title,
    required this.isCompleted,
    this.taskId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
      'taskId': taskId,
    };
  }

  static SubTaskModel fromMap(Map<String, dynamic> map) {
    return SubTaskModel(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
      taskId: map['taskId'],
    );
  }
}
