import 'package:bloc/bloc.dart';
import 'package:todo_app/Logic/TaskCubit/task_state.dart';
import 'package:todo_app/data/isar_data_base_of_tasks.dart';
import 'package:todo_app/models/task.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  String? _userId;

  String? get currentUserId => _userId;

  Future<void> loadTasksForUser(String userId) async {
    _userId = userId;
    await loadTasks();
  }

  Future<void> loadTasks() async {
    final userId = _userId;
    if (userId == null) {
      emit(TaskError('User id not set for TaskCubit'));
      return;
    }

    try {
      final tasks = await IsarDataBaseOfTasks.getTasksByUserId(userId);
      int numOfComlatedTask = 0;
      if (tasks.isNotEmpty) {
        for (int i = 0; i < tasks.length; i++) {
          if (tasks[i].isCompleted) {
            numOfComlatedTask += 1;
          }
        }
        emit(TaskLoaded(tasks, numOfComlatedTask));
      } else {
        emit(TaskEmpty());
      }
    } catch (e) {
      emit(TaskError("Failed to load tasks: $e"));
      throw Exception("Failed to load tasks: $e");
    }
  }

  Future<void> addTask(Task task) async {
    final userId = _userId;
    if (userId == null) {
      emit(TaskError('User id not set for TaskCubit'));
      return;
    }
    task.userID = userId;

    try {
      await IsarDataBaseOfTasks.addTask(task);
      await loadTasks();
    } catch (e) {
      emit(TaskError("Failed to add task: $e"));
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await IsarDataBaseOfTasks.updateTask(task);
      await loadTasks();
    } catch (e) {
      emit(TaskError("Failed to update task: $e"));
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await IsarDataBaseOfTasks.deleteTask(id);
      await loadTasks();
    } catch (e) {
      emit(TaskError("Failed to delete task: $e"));
    }
  }

  Future<void> deleteAllTasks() async {
    final userId = _userId;
    if (userId == null) {
      emit(TaskError('User id not set for TaskCubit'));
      return;
    }
    try {
      final tasks = await IsarDataBaseOfTasks.getTasksByUserId(userId);

      if (tasks.isEmpty) {
        emit(TaskEmptyDelateWarning());

        return;
      }

      emit(TaskDelateAllWarning());
      await loadTasks();
    } catch (e) {
      emit(TaskError('Failed to check tasks before delete: $e'));
    }
  }

  Future<void> confirmDeleteAllTasks() async {
    final userId = _userId;
    if (userId == null) {
      emit(TaskError('User id not set for TaskCubit'));
      return;
    }
    try {
      await IsarDataBaseOfTasks.deleteTasksByUserId(userId);
      await loadTasks();
    } catch (e) {
      emit(TaskError('Failed to delete all tasks: $e'));
    }
  }

  void clear() {
    _userId = null;
    emit(TaskInitial());
  }
}
