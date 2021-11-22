import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/data/models/task.dart';

class TasksDataBase {
  // Singleton DatabaseHelper
  static final TasksDataBase instance = TasksDataBase._instance();

  // Singleton Database
  static late Database _db;

  TasksDataBase._instance();

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "tasks.db";
    return await openDatabase(path, version: 1, onCreate: _createDB,
        onOpen: (database) {
      print("dataBase Opened");
    });
  }

  Future<Database> get db async {
    _db = await _initDB();
    return _db;
  }

  Future<void> _createDB(Database db, int version) async {
    print("dataBase Created");
    await db
        .execute(
      'CREATE TABLE $taskTable ($colID INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colContent TEXT,$colDate TEXT,$colStartTime TEXT,'
      '$colEndTime TEXT , $colRemind INTEGER , $colRepeat TEXT , $colColor INTEGER , $colIsCompleted INTEGER )',
    )
        .catchError((error) {
      print(error.toString());
    });
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result =
        await db.query(taskTable, orderBy: "id DESC").catchError((error) {
      print(error.toString());
    });
    return result;
  }

  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    return await db.insert(taskTable, task.toMap());
  }

  Future<int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(taskTable, task.toMap(),
        where: "$colID = ?", whereArgs: [task.id]).catchError((error) {
      print(error.toString());
    });
    return result;
  }

  Future<int> updateTaskToComplete(int id) async {
    Database db = await this.db;
    final int result = await db.rawUpdate(
        ''' UPDATE $taskTable SET $colIsCompleted = ? WHERE $colID = ? ''',
        [1, id]).catchError((error) {
      print(error.toString());
    });
    return result;
  }

  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result = await db.delete(taskTable,
        where: "$colID = ?", whereArgs: [id]).catchError((error) {
      print(error.toString());
    });
    return result;
  }

  Future<void> closeDB() async {
    Database db = await this.db;
    await db.close();
  }
}
