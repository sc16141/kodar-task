import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'data/repositories/task_repositories.dart';
import 'logic/bloc/task_bloc.dart';
import 'logic/theme_cubit/theme_cubit.dart';
final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(() => TaskBloc(taskRepository: sl()));


  sl.registerFactory(() => ThemeCubit());


  sl.registerLazySingleton(() => TaskRepository());

  sl.registerLazySingleton(() => http.Client());
}