import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/models/task.dart';

class IsarDataBase {
  static late Isar _isar;
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TaskSchema], directory: dir.path);
  }

  // static Isar get isar {
  //   if (_isar == null) {
  //     throw Exception('Isar not initialized. Call IsarService.init() first.');
  //   }
  //   return _isar!;
  // }

  // ----------------- CRUD OPERATIONS -----------------

  //Add a new task
  static Future<int> addTask(Task task) async {
    return await _isar.writeTxn(() async {
      return await _isar.tasks.put(task);
    });
  }

  //Get All Task
  static Future<List<Task>> getAllTasks() async {
    final tasks = await _isar.tasks.where().findAll();
    return tasks;
  }

  /// Get a single task by id
  static Future<Task?> getTaskById(int id) async {
    return await _isar.tasks.get(id);
  }

  /// Update a task
  static Future<void> updateTask(Task updatedTask) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.put(updatedTask);
    });
  }

  /// Delete a task by id
  static Future<void> deleteTask(int id) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.delete(id);
    });
  }

  /// Delete all tasks
  static Future<void> deleteAllTasksFromDB() async {
    await _isar.writeTxn(() async {
      await _isar.tasks.clear();
    });
  }
}
