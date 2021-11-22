import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/app_routing.dart';
import 'package:todo_app/business_logic/theme/theme_cubit.dart';
import 'package:todo_app/data/repositories/tasks_repository.dart';
import 'business_logic/task/task_cubit.dart';
import 'constants/theme.dart';
import 'data/services/dataBase/tasks_database.dart';
import 'data/services/notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  await TasksDataBase.instance.db;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<TaskCubit>(
          create: (context) => TaskCubit(
              tasksRepository:
                  TasksRepository(tasksDataBase: TasksDataBase.instance)),
        ),
      ],
      child: MyTodo(
        appRouting: AppRouting(),
      ),
    ),
  );
}

class MyTodo extends StatelessWidget {
  final AppRouting appRouting;

  const MyTodo({Key? key, required this.appRouting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouting.generateRoute,
          themeMode: state ? ThemeMode.dark : ThemeMode.light,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          navigatorKey: NotifyHelper.navigatorKey,
        );
      },
    );
  }
}
