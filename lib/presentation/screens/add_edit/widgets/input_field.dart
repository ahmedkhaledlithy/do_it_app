import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/theme/theme_cubit.dart';
import 'package:todo_app/constants/colors_app.dart';
import 'package:todo_app/constants/theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const InputField({Key? key,required this.title,required this.hint,  this.controller, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme=BlocProvider.of<ThemeCubit>(context);

    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle(context)),
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsApp.grayColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget!=null?true:false,
                    controller: controller,
                    cursorColor: theme.state ? Colors.grey[100] : Colors.grey[700],
                    style: subTitleStyle(context),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle(context),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                widget==null?Container():Container(child: widget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
