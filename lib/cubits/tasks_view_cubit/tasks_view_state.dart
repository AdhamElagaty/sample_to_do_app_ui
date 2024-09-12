sealed class TasksViewState {}

final class TasksViewStateInitial extends TasksViewState {}

final class UpdateDateViewTasksSuccess extends TasksViewState {}

final class UpdateDataViewTasksSuccess extends TasksViewState {}

final class UpdateDataViewTasksNotExist extends TasksViewState {}

final class UpdateDataViewTasksFailure extends TasksViewState {
  final String errorMessage;

  UpdateDataViewTasksFailure({required this.errorMessage});
}
