sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

final class AddTaskSuccess extends AddTaskState {}

final class AddTaskFailure extends AddTaskState {
  final String errorMessage;

  AddTaskFailure({required this.errorMessage});
}

final class AddSubTaskInitial extends AddTaskState {}

final class AddSubTaskSuccess extends AddTaskState {}

final class RemoveSubTaskSuccess extends AddTaskState {}

final class AddSubTaskFailure extends AddTaskState {
  final String errorMessage;

  AddSubTaskFailure({required this.errorMessage});
}
