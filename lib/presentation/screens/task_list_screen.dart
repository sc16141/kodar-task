import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodar_task/core/app_colors.dart';

import '../../logic/bloc/task_bloc.dart';
import '../../logic/bloc/task_event.dart';
import '../../logic/bloc/task_state.dart';
import 'edit_task_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/task_model.dart';

import '../../logic/theme_cubit/theme_cubit.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Manager',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Toggle Theme',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode,color: AppColors.primaryLight,),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),

          // 2. Refresh Button
          IconButton(
            tooltip: 'Refresh List',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<TaskBloc>().add(LoadTasks());
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/task');
        },
        child: const Icon(Icons.add),
      ),

      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {

          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Case B: Error State
          if (state is TaskError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 10),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => context.read<TaskBloc>().add(LoadTasks()),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Retry"),
                    )
                  ],
                ),
              ),
            );
          }

          // Case C: Data Loaded
          if (state is TaskLoaded) {
            // Case C.1: Empty List
            if (state.tasks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_outlined,
                        size: 64,
                        color: Colors.grey.withOpacity(0.5)),
                    const SizedBox(height: 16),
                    Text(
                      "No tasks found.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.withOpacity(0.8)
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text("Tap '+' to create one!"),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.tasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return _buildTaskCard(context, task);
              },
            );
          }

          return const SizedBox(); // Initial State
        },
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, TaskModel task) {
    final isCompleted = task.isCompleted;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        leading: Checkbox(
          value: isCompleted,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (val) {
            if (val != null) {
              context.read<TaskBloc>().add(
                  UpdateTask(task.copyWith(isCompleted: val))
              );
            }
          },
        ),

        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: task.description.isNotEmpty
            ? Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            task.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isCompleted ? Colors.grey.shade400 : null,
            ),
          ),
        )
            : null,

        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Delete Task?"),
                content: const Text("Are you sure you want to delete this task?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<TaskBloc>().add(DeleteTask(task.id));
                      Navigator.pop(ctx);
                    },
                    child: const Text("Delete", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        ),

        onTap: () {
          context.push('/task', extra: task);
        },
      ),
    );
  }
}
