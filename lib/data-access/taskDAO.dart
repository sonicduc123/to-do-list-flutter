import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/model/task.dart';

class TaskDAO {
  Database? database;

  final databaseName = "todolist.db";

  Future open(String databaseName) async {
    database = await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          'create table Task(taskID text primary key, taskTitle text, taskDate text, taskTime text)');
    });
  }

  void insert(Task task) async {
    await open(databaseName);
    await database?.insert('Task', task.toMap());
    await close();
  }

  Future<List<Task>> getTasks() async {
    await open(databaseName);
    final List<Map<String, dynamic>>? maps = await database?.query('Task');
    await close();

    return List.generate(
      maps!.length,
      (index) => new Task(
        int.parse(maps[index]['taskID']),
        maps[index]['taskTitle'],
        maps[index]['taskDate'],
        maps[index]['taskTime'],
      ),
    );
  }

  void delete(String id) async {
    await open(databaseName);
    await database?.delete(
      'Task',
      where: 'taskID = ?',
      whereArgs: [id],
    );
    await close();
  }

  Future close() async {
    await database?.close();
  }
}
