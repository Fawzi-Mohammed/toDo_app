import 'package:todo_app/models/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
   final int numOfComlatedTask;

  TaskLoaded(this.tasks, this.numOfComlatedTask);
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}

class TaskEmpty extends TaskState {
}

class TaskEmptyDelateWarning extends TaskState{

}
class TaskDelateAllWarning extends TaskState{
  
}


