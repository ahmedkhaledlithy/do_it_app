part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}


//class CreateDataBaseState extends TaskState {}
class TaskLoadingState extends TaskState {}

class AddTaskState extends TaskState {}
class UpdateTaskState extends TaskState {}
class DeleteTaskState extends TaskState {}

class IsCompleteState extends TaskState {}

class GetTasksState extends TaskState {
 final List<Task>tasks;

  GetTasksState({required this.tasks});
}

