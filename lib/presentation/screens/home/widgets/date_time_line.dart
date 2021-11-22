import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/constants/colors_app.dart';


typedef ValueCallback = void Function(DateTime date);


class DateBar extends StatelessWidget {
  final ValueCallback callback;
  const DateBar({Key? key,required this.callback}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15,top: 20),
      child:   DatePicker(
        DateTime.now(),
        height: 100,
        width: 75,
        initialSelectedDate: DateTime.now(),
        selectionColor: ColorsApp.primaryColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              color: ColorsApp.grayColor,
              fontWeight: FontWeight.w600,
              fontSize: 20
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              color: ColorsApp.grayColor,
              fontWeight: FontWeight.w600,
              fontSize: 15
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              color: ColorsApp.grayColor,
              fontWeight: FontWeight.w600,
              fontSize: 12
          ),
        ),
        onDateChange: (date) {
            callback(date);
        },
      ),
    );
  }
}
