import 'package:bloc/bloc.dart';
import 'package:todo_app/Logic/TaskCubit/task_state.dart';
import 'package:todo_app/data/isar_data_base_of_tasks.dart';
import 'package:todo_app/models/task.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  Future<void> loadTasks() async {
    try {
      final tasks = await IsarDataBaseOfTasks.getAllTasks();
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
    try {
      final tasks = await IsarDataBaseOfTasks.getAllTasks();

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
    try {
      await IsarDataBaseOfTasks.deleteAllTasksFromDB();
      await loadTasks();
    } catch (e) {
      emit(TaskError('Failed to delete all tasks: $e'));
    }
  }
}
