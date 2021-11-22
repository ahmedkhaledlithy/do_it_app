import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/theme/theme_cubit.dart';
import 'package:todo_app/constants/colors_app.dart';
import 'package:todo_app/constants/theme.dart';

class NotifyDetailsScreen extends StatelessWidget {
  final String label;

  const NotifyDetailsScreen({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 23,
            color: theme.state ? ColorsApp.whiteColor : ColorsApp.primaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          label.split("|")[0],
          style: TextStyle(
              color: theme.state ? ColorsApp.whiteColor : Colors.grey[900],
              fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Transform.translate(
            offset: Offset(0,20),
            child: Text(
              "Hello EveryOne",
              style: headingStyle(context),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
              padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
              decoration: BoxDecoration(
                color: ColorsApp.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildCard("Title :", 0),
                    ..._buildCard("Content :", 1),
                    ..._buildCard("Date :", 2),
                    ..._buildCard("Time :", 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCard(String title, int index) {
    return [
      Text(title, style: TextStyle(color: ColorsApp.whiteColor, fontSize: 30)),
      SizedBox(height: 5),
      Text(label.split("|")[index],
          style: TextStyle(
              color: ColorsApp.whiteColor.withOpacity(0.6), fontSize: 25)),

      SizedBox(height: 5),
      Divider(color: ColorsApp.whiteColor),
      SizedBox(height: 5),
    ];
  }
}
