import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/business_logic/task/task_cubit.dart';
import 'package:todo_app/constants/colors_app.dart';
import 'package:todo_app/constants/theme.dart';
import 'package:todo_app/data/models/task.dart';
import '../../../../shared/button.dart';


class BottomAddTask extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController noteController;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String repeat;
  final int remind;
  final Task? task;

  const BottomAddTask(
      {Key? key, required this.titleController,required this.noteController,required this.startTime,required this.endTime,
        required this.date,
        required this.repeat,required this.remind, this.task,
      })
      : super(key: key);

  @override
  State<BottomAddTask> createState() => _BottomAddTaskState();
}

class _BottomAddTaskState extends State<BottomAddTask> {
  late int _selectedColor;

  @override
  void initState() {
    widget.task!.color==null?_selectedColor = 0 : _selectedColor = widget.task!.color!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Color", style: titleStyle(context)),
            SizedBox(
              height: 8,
            ),
            Wrap(
              children: List<Widget>.generate(3, (index) {
                return GestureDetector(
                  onTap: () {
                      setState(() {
                        _selectedColor=index;
                      });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: index == 0
                          ? ColorsApp.primaryColor
                          : index == 1
                              ? ColorsApp.pinkColor
                              : ColorsApp.yellowColor,

                      child: _selectedColor == index?
                            Icon(
                              Icons.done,
                              color: ColorsApp.whiteColor,
                              size: 20,
                            )
                          : Container(),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        ButtonWidget(
          label: widget.task!.id==null?'Create Task' : 'Update Task',
          onTap: () {
            if (widget.titleController.text.isNotEmpty && widget.noteController.text.isNotEmpty) {

                if(widget.task!.id==null)
                  addTaskToDb(context);
                else
                updateTaskToDb(context);

              Navigator.pop(context);
            } else if(widget.titleController.text.isEmpty || widget.noteController.text.isEmpty) {
              _showSnackBar(context);
            }
          },
        ),
      ],
    );
  }

 void _showSnackBar(BuildContext context){

   ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        content: Container(
          height: 50,
          child: Row(
            children: [
              Icon(Icons.warning,color: Colors.red),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Required',style: TextStyle(color: ColorsApp.pinkColor,fontSize: 24,fontWeight: FontWeight.bold),),
                  Text('Please Complete The Fields',style: TextStyle(color: ColorsApp.pinkColor,fontSize: 14),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  void addTaskToDb(BuildContext context){
    BlocProvider.of<TaskCubit>(context).insertTask(task: Task(
      title: widget.titleController.text,
      content: widget.noteController.text,
      date: DateFormat.yMd().format(widget.date),
      startTime: widget.startTime,
      endTime: widget.endTime,
      remind: widget.remind,
      repeat: widget.repeat,
      color: _selectedColor,
      isCompleted: 0,
    ));

  }

  void updateTaskToDb(BuildContext context){
    BlocProvider.of<TaskCubit>(context).updateTask(task: Task(
      id: widget.task!.id,
      title: widget.titleController.text,
      content: widget.noteController.text,
      date: DateFormat.yMd().format(widget.date),
      startTime: widget.startTime,
      endTime: widget.endTime,
      remind: widget.remind,
      repeat: widget.repeat,
      color: _selectedColor,
    ),
    );

  }

}
