import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors_app.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const ButtonWidget({Key? key,required this.label,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorsApp.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
            label,
          style: TextStyle(
            color: ColorsApp.whiteColor,
          ),
        ),
      ),
    );
  }
}
