import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/quick_services.dart';
import 'core/constants/router/app_routes.dart';
import 'core/constants/theme/app_theme.dart';
import 'injection_container.dart' as di;
import 'logic/bloc/task_bloc.dart';
import 'logic/bloc/task_event.dart';

import 'logic/theme_cubit/theme_cubit.dart';

// New Service Import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Service ka instance banaya
  final QuickActionsService _quickActionsService = QuickActionsService();

  @override
  void initState() {
    super.initState();
    // Logic ab alag file me hai, yahan bas call kiya
    _quickActionsService.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => di.sl<TaskBloc>()..add(LoadTasks()),
            ),
            BlocProvider(
              create: (_) => di.sl<ThemeCubit>(),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                title: 'Task Manager',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                routerConfig: AppRouter.router,
              );
            },
          ),
        );
      },
    );
  }
}