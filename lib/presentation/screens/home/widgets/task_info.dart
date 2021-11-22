import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_app/business_logic/task/task_cubit.dart';
import 'package:todo_app/business_logic/theme/theme_cubit.dart';
import 'package:todo_app/constants/colors_app.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/screens/home/widgets/task_tile.dart';

import 'bottom_sheet_button.dart';

class TaskInfo extends StatelessWidget {
  final Task task;
  final int index;

  const TaskInfo({Key? key, required this.task, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Row(
            children: [
              GestureDetector(
                child: TaskTile(task: task),
                onTap: () {
                  showSheet(context, task);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSheet(BuildContext context, Task task) {
    final theme = BlocProvider.of<ThemeCubit>(context);
    showModalBottomSheet(
      context: context,
      isDismissible:  false,
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 10),
          height: task.isCompleted == 1
              ? MediaQuery.of(context).size.height * 0.35
              : MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.state ? Colors.grey[600] : Colors.grey[300],
                ),
              ),
              Spacer(),
              task.isCompleted == 1
                  ? Container()
                  : BottomSheetButton(
                      label: 'Task Completed',
                      onTap: () {
                        BlocProvider.of<TaskCubit>(context).markTaskCompleted(task.id!);
                        Navigator.pop(context);
                      },
                      bgColor: ColorsApp.primaryColor,
                      theme: theme,
                    ),
              task.isCompleted == 1
                  ? Container()
                  : BottomSheetButton(
                label: 'Update Task',
                onTap: () {
                  Navigator.pushReplacementNamed(context, addEditScreen,arguments: task);
                },
                bgColor: Colors.green.shade600,
                theme: theme,
              ),
              BottomSheetButton(
                label: 'Delete Task',
                onTap: () {
                  BlocProvider.of<TaskCubit>(context).deleteTask(task.id!);
                  Navigator.pop(context);
                },
                bgColor: Colors.red.shade600,
                theme: theme,
              ),
             SizedBox(height: 35,),
              BottomSheetButton(
                label: 'Close',
                onTap: () {
                  Navigator.pop(context);
                },
                bgColor: ColorsApp.transparent,
                theme: theme,
                isClose: true,
              ),
              SizedBox(height: 10,),
            ],
          ),
        );
      },
    );
  }
}
