import 'package:flutter/material.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/screens/add_edit/pages/add_edit_screen.dart';
import 'package:todo_app/presentation/screens/home/pages/home_screen.dart';
import 'package:todo_app/presentation/screens/notification_details_screen.dart';


class AppRouting {


  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case addEditScreen:
        final  selectedTask = settings.arguments as Task;
        return MaterialPageRoute(
          builder: (_) => AddEditScreen(task: selectedTask),
        );

      case notifyDetailsScreen:
        final  label = settings.arguments as String;
        return MaterialPageRoute(builder: (_) =>  NotifyDetailsScreen(label: label,));
    }
  }
}
