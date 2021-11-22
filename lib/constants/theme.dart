import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/business_logic/theme/theme_cubit.dart';
import 'colors_app.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: ColorsApp.primaryColor,
    brightness: Brightness.light,
    backgroundColor: ColorsApp.whiteColor,
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: ColorsApp.darkGreyColor,
      brightness: Brightness.dark,
    backgroundColor: ColorsApp.darkGreyColor,
  );
}


TextStyle  subHeadingStyle(BuildContext context){
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: context.read<ThemeCubit>().state ? ColorsApp.lightGrayColor: ColorsApp.grayColor,
    ),
  );
}

TextStyle  headingStyle (BuildContext context){
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: context.read<ThemeCubit>().state ? ColorsApp.whiteColor : ColorsApp.blackColor,
    ),
  );
}

TextStyle  titleStyle (BuildContext context){
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: context.read<ThemeCubit>().state ? ColorsApp.whiteColor : ColorsApp.blackColor,
    ),
  );
}

TextStyle  subTitleStyle (BuildContext context){
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: context.read<ThemeCubit>().state ? Colors.grey[100] : Colors.grey[600],
    ),
  );
}
