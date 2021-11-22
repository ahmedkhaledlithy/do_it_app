import 'package:flutter/material.dart';
import 'package:todo_app/business_logic/theme/theme_cubit.dart';
import 'package:todo_app/constants/colors_app.dart';
import 'package:todo_app/constants/theme.dart';

class BottomSheetButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final Color bgColor;
  final bool isClose;
  final ThemeCubit theme;

  const BottomSheetButton(
      {Key? key,
      required this.onTap,
      required this.label,
      required this.bgColor,
      this.isClose = false,
      required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 60,
        width: MediaQuery.of(context).size.width * 0.9,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
          border: Border.all(
              width: 1.5,
              color: isClose == true
                  ? theme.state
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : bgColor),
        ),
        child: Text(
          label,
          style: isClose == true
              ? titleStyle(context)
              : titleStyle(context).copyWith(color: ColorsApp.whiteColor),
        ),
      ),
    );
  }
}
