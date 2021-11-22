import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constants/theme.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/presentation/screens/add_edit/widgets/bottom_add_task.dart';
import 'package:todo_app/presentation/screens/add_edit/widgets/custom_app_bar.dart';
import 'package:todo_app/presentation/screens/add_edit/widgets/input_field.dart';


class AddEditScreen extends StatefulWidget {

  final Task? task;
  const AddEditScreen({Key? key, this.task}) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late DateTime _selectedDate;
  late String _startTime;
  late String _endTime;

 late int _selectedRemind ;
  List<int> _remindedList = [5, 10, 15, 20];
 late String _selectedRepeat ;
  List<String> _repeatList = ["None", "Daily", "Weekly", "Monthly"];
  late final TextEditingController _titleController;
  late final TextEditingController _noteController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task!.title ?? "");
    _noteController = TextEditingController(text: widget.task!.content ?? "");
    _selectedDate = widget.task!.date == null
        ? DateTime.now()
        : DateFormat.yMd().parse(widget.task!.date!);
    _startTime = widget.task!.startTime == null
        ? DateFormat("hh:mm a").format(DateTime.now()).toString()
        : widget.task!.startTime!;
    _endTime = widget.task!.endTime == null
        ? DateFormat("hh:mm a")
            .format(DateTime.now().add(Duration(hours: 1)))
            .toString()
        : widget.task!.endTime!;

    _selectedRemind=widget.task!.remind == null ? 5 : widget.task!.remind! ;
    _selectedRepeat= widget.task!.repeat == null ? "None" : widget.task!.repeat! ;

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task!.id == null ? "Add Task" : "Update Task",
                style: headingStyle(context),
              ),
              InputField(
                title: "Title",
                hint: "Enter The Title",
                controller: _titleController,
              ),
              InputField(
                title: "Note",
                hint: "Enter The Note",
                controller: _noteController,
              ),
              InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: Icon(Icons.calendar_today_outlined),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        icon: Icon(Icons.access_time_rounded),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: Icon(Icons.access_time_rounded),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                title: "Remind",
                hint:
                    "$_selectedRemind  minutes early",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(),
                  style: subTitleStyle(context),
                  items:
                      _remindedList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      child: Text(value.toString()),
                      value: value.toString(),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRemind = int.parse(value!);
                    });
                  },
                ),
              ),
              InputField(
                title: "Repeat",
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(),
                  style: subTitleStyle(context),
                  items:
                      _repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepeat = value!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              BottomAddTask(
                  titleController: _titleController,
                  noteController: _noteController,
                  date: _selectedDate,
                  startTime: _startTime,
                  endTime: _endTime,
                  remind: _selectedRemind,
                  repeat: _selectedRepeat,
                  task: widget.task),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<DateTime?> _getDateFromUser() async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2125),
    );
    if (_datePicker != null) {
      setState(() {
        _selectedDate = _datePicker;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Date Canceled")));
    }
  }

  void _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickTime = await _showTimePicker();
    if (pickTime == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Time Canceled")));
    } else if (isStartTime == true) {
      setState(() {
        _startTime = pickTime.format(context);
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = pickTime.format(context);
      });
    }
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
      initialEntryMode: TimePickerEntryMode.input,
    );
  }

}
