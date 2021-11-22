import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/theme/theme_cubit.dart';
import 'package:todo_app/constants/colors_app.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget  {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context);

    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 23,
          color: theme.state ? ColorsApp.whiteColor : ColorsApp.primaryColor,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20, top: 5),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
        ),
      ],
    );
  }
}
