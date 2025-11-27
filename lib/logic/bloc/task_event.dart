import 'package:equatable/equatable.dart';
import '../../data/models/task_model.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String description;

  const AddTask({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  const UpdateTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String taskId;

  const DeleteTask(this.taskId);

  @override
  List<Object> get props => [taskId];
}