import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/data/services/dataBase/tasks_database.dart';

class TasksRepository{
  final TasksDataBase tasksDataBase;
  TasksRepository({required this.tasksDataBase});



  Future<int> addTask(Task task) async{
    return await tasksDataBase.insertTask(task);
  }

  Future<int> updateTask(Task task) async{
    return await tasksDataBase.updateTask(task);
  }


  Future<int> markTaskComplete(int id) async{
    return await tasksDataBase.updateTaskToComplete(id);
  }

  Future<int> deleteTask(int id) async{
    return await tasksDataBase.deleteTask(id);
  }

  Future<List<Task>> getTasks() async{
    final List<Map<String, dynamic>> taskMapList = await tasksDataBase.getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });

    return taskList;

  }


}