enum TaskStatus {
  notBegun,
  inProgress,
  completed,
}

extension TaskStatusExtension on TaskStatus {
  int get value {
    switch (this) {
      case TaskStatus.notBegun:
        return 1;
      case TaskStatus.inProgress:
        return 2;
      case TaskStatus.completed:
        return 3;
    }
  }

  static TaskStatus fromValue(int value) {
    switch (value) {
      case 1:
        return TaskStatus.notBegun;
      case 2:
        return TaskStatus.inProgress;
      case 3:
        return TaskStatus.completed;
      default:
        throw ArgumentError('Invalid value: $value');
    }
  }
}
