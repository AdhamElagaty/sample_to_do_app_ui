sealed class TaskState {}

final class TaskStateInitial extends TaskState {}

final class TaskStateOpen extends TaskState {}

final class TaskStateClosed extends TaskState {}

final class TaskStateChange extends TaskState {}

final class TaskStateDeleted extends TaskState {}

final class TaskStateSubTaskDeleted extends TaskState {}
