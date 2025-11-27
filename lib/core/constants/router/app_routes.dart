

import 'package:go_router/go_router.dart';

import '../../../data/models/task_model.dart';
import '../../../presentation/screens/edit_task_screen.dart';
import '../../../presentation/screens/task_list_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      //  Home Route
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const TaskListScreen(),
      ),


      GoRoute(
        path: '/task',
        name: 'task',
        builder: (context, state) {
          final task = state.extra as TaskModel?;
          return AddEditTaskScreen(task: task);
        },
      ),
    ],
  );
}