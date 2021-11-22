import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/business_logic/task/task_cubit.dart';
import 'package:todo_app/data/services/notifications.dart';
import 'package:todo_app/presentation/screens/home/widgets/task_info.dart';

class ShowTasks extends StatelessWidget {
  final DateTime dateLine;

  const ShowTasks({Key? key, required this.dateLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (BuildContext context, state) {
          if (state is TaskLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetTasksState) {
            final data = state.tasks;
            return AnimationLimiter(
              child: ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  DateTime date = DateFormat.jm().parse(data[index].startTime!);
                  String time = DateFormat("HH:mm").format(date);

                  if (data[index].repeat == "Daily") {
                    NotifyHelper().scheduledNotification(
                      task: data[index],
                      hour: int.parse(time.split(":")[0]),
                      minute: int.parse(time.split(":")[1]),
                    );
                    return TaskInfo(task: data[index], index: index);
                  } else if (DateFormat.yMd().format(dateLine) ==
                      data[index].date) {
                    NotifyHelper().scheduledNotification(
                      task: data[index],
                      hour: int.parse(time.split(":")[0]),
                      minute: int.parse(time.split(":")[1]),
                    );
                    return TaskInfo(
                      task: data[index],
                      index: index,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
