import 'package:isar/isar.dart';
import 'package:todo_app/data/isar_data_base_service.dart';
import 'package:todo_app/models/task.dart';

class IsarDataBaseOfTasks {
  static final _isar = IsarService.isar;

  // ----------------- CRUD OPERATIONS -----------------

  // Add a new task
  static Future<int> addTask(Task task) async {
    return await _isar.writeTxn(() async {
      return await _isar.tasks.put(task);
    });
  }

  // Get all tasks
  static Future<List<Task>> getAllTasks() async {
    final tasks = await _isar.tasks.where().findAll();
    return tasks;
  }

  // Get tasks by user ID
  static Future<List<Task>> getTasksByUserId(String userId) async {
    final tasks = await _isar.tasks.filter().userIDEqualTo(userId).findAll();
    return tasks;
  }

  // Delete tasks by user ID
  static Future<void> deleteTasksByUserId(String userId) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.filter().userIDEqualTo(userId).deleteAll();
    });
  }

  // Get a single task by id
  static Future<Task?> getTaskById(int id) async {
    return await _isar.tasks.get(id);
  }

  // Update a task
  static Future<void> updateTask(Task updatedTask) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.put(updatedTask);
    });
  }

  // Delete a task by id
  static Future<void> deleteTask(int id) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.delete(id);
    });
  }

  // Delete all tasks
  static Future<void> deleteAllTasksFromDB() async {
    await _isar.writeTxn(() async {
      await _isar.tasks.clear();
    });
  }
}
