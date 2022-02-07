import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:zipcursos_app/models/student.dart';

class TimerPickerCustom extends StatefulWidget {
  final StudentModel student;
  final Map mapValuesClassTimes;
  const TimerPickerCustom(
      {Key? key, required this.student, required this.mapValuesClassTimes})
      : super(key: key);

  @override
  State<TimerPickerCustom> createState() => _TimerPickerCustomState();
}

class _TimerPickerCustomState extends State<TimerPickerCustom> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(2, (index) {
      return Row(children: <Widget>[
        const Expanded(
          flex: 2,
          child: Text("title"),
        ),
        Expanded(
          flex: 3,
          child: DateTimeField(
            format: DateFormat("HH:mm"),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
        ),
      ]);
    }));
  }
}
