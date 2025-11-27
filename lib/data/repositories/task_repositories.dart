import 'dart:convert'; // JSON decode ke liye zaroori hai
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/task_model.dart';

class TaskRepository {
  // 1. GET: Fetch all tasks
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.tasksEndpoint}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => TaskModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  // 2. POST: Add new task
  Future<TaskModel> addTask(String title, String description) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.tasksEndpoint}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'description': description,
          'isCompleted': false,
        }),
      );

      if (response.statusCode == 201) {
        return TaskModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add task');
      }
    } catch (e) {
      throw Exception('Error adding task: $e');
    }
  }

  // 3. PUT: Update task (Edit or Mark as Completed)
  Future<void> updateTask(TaskModel task) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.tasksEndpoint}/${task.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update task');
      }
    } catch (e) {
      throw Exception('Error updating task: $e');
    }
  }

  // 4. DELETE: Remove task
  Future<void> deleteTask(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.tasksEndpoint}/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete task');
      }
    } catch (e) {
      throw Exception('Error deleting task: $e');
    }
  }
}