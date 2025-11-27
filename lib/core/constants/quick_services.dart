import 'package:kodar_task/core/constants/router/app_routes.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsService {
  final QuickActions _quickActions = const QuickActions();

  void init() {
    // 1. Setup Callback (Action handle karna)
    _quickActions.initialize((shortcutType) {
      if (shortcutType == 'add_task') {
        // Thoda wait karein taaki app ready ho jaye
        Future.delayed(const Duration(milliseconds: 500), () {
          // GoRouter ka use karke navigate karein
          AppRouter.router.push('/task');
        });
      }
    });

    // 2. Create Items (Shortcuts banana)
    _quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'add_task',
        localizedTitle: 'Add New Task',
        icon: 'add', // Drawable folder wala icon name
      ),
    ]);
  }
}