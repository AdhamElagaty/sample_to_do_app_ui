sealed class TasksViewState {}

final class TasksViewStateInitial extends TasksViewState {}

final class TasksViewSuccess extends TasksViewState {}

final class TasksViewFailure extends TasksViewState {
  final String errorMessage;

  TasksViewFailure({required this.errorMessage});
}

final class UpdateDateViewTasksSuccess extends TasksViewState {}

final class UpdateDataViewTasksSuccess extends TasksViewState {}

final class UpdateDataViewTasksNotExist extends TasksViewState {}

final class UpdateDataViewTasksFailure extends TasksViewState {
  final String errorMessage;

  UpdateDataViewTasksFailure({required this.errorMessage});
}
