import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/data/repositories/tasks_repository.dart';
part 'task_state.dart';


class TaskCubit extends Cubit<TaskState> {

  final TasksRepository tasksRepository;
  TaskCubit({required this.tasksRepository}) : super(TaskInitial());



 Future<void> insertTask({required Task task})async{
   await tasksRepository.addTask(task);
   emit(AddTaskState());
   getTasks();
  }
  Future<void> updateTask({required Task task}) async{
     await tasksRepository.updateTask(task);
     emit(UpdateTaskState());
     getTasks();
  }

  Future<void> markTaskCompleted(int id) async{
    await tasksRepository.markTaskComplete(id);
    emit(IsCompleteState());
    getTasks();
  }

  Future<void> deleteTask(int id) async{
     await tasksRepository.deleteTask(id);
     emit(DeleteTaskState());
     getTasks();
  }

  Future<void> getTasks() async{
    emit(TaskLoadingState());
    List<Task> tasks= await tasksRepository.getTasks();
     emit(GetTasksState(tasks: tasks));
  }
}
