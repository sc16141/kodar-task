import 'package:bloc/bloc.dart';

import '../../data/repositories/task_repositories.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TaskInitial()) {

    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await taskRepository.getTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<AddTask>((event, emit) async {
      emit(TaskLoading());
      try {
        await taskRepository.addTask(event.title, event.description);
        add(LoadTasks());
      } catch (e) {
        emit(TaskError("Failed to add task: ${e.toString()}"));
      }
    });

    on<UpdateTask>((event, emit) async {
      emit(TaskLoading());
      try {
        await taskRepository.updateTask(event.task);
        add(LoadTasks()); // Refresh list
      } catch (e) {
        emit(TaskError("Failed to update task: ${e.toString()}"));
      }
    });

    on<DeleteTask>((event, emit) async {
      emit(TaskLoading());
      try {
        await taskRepository.deleteTask(event.taskId);
        add(LoadTasks());
      } catch (e) {
        emit(TaskError("Failed to delete task: ${e.toString()}"));
      }
    });
  }
}