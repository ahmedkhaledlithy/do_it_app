import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/constants/theme.dart';
import 'package:todo_app/data/models/task.dart';

import '../../../../shared/button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle(context),
              ),
              Text(
                "Today",
                style: headingStyle(context),
              ),
            ],
          ),
          ButtonWidget(
            label: "+ Add Task",
            onTap: () {
              Navigator.pushNamed(context, addEditScreen,arguments: Task());
            },
          ),
        ],
      ),
    );
  }
}
