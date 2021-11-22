import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/task/task_cubit.dart';
import 'package:todo_app/business_logic/theme/theme_cubit.dart';
import 'package:todo_app/constants/colors_app.dart';
import 'package:todo_app/data/services/dataBase/tasks_database.dart';
import 'package:todo_app/data/services/notifications.dart';
import 'package:todo_app/presentation/screens/home/widgets/date_time_line.dart';
import 'package:todo_app/presentation/screens/home/widgets/home_header.dart';
import 'package:todo_app/presentation/screens/home/widgets/show_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NotifyHelper notifyHelper;
  DateTime selectedDate=DateTime.now();

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    BlocProvider.of<TaskCubit>(context).getTasks();

  }

  @override
  void dispose() {
    TasksDataBase.instance.closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          HomeHeader(),
          DateBar(
            callback: (DateTime date) {
            setState(() {
              selectedDate=date;
            });
          },),
          SizedBox(height: 15,),
          ShowTasks(dateLine: selectedDate),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          ThemeCubit theme = BlocProvider.of<ThemeCubit>(context);
          return GestureDetector(
            onTap: () {
              theme.changeTheme(value: !state);

              notifyHelper.displayNotification(
                  title: "Theme Changed",
                  body: !state ? "Theme is DarkMode" : "Theme is LightMode");
            },
            child:  Icon(
              state ?Icons.wb_sunny_outlined :Icons.nightlight_outlined,
              size: 23,
              color: state ? ColorsApp.whiteColor: ColorsApp.blackColor,
            ),
          );
        },
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20,top: 5),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
        ),
      ],
    );
  }
}
