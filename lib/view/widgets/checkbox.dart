import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/widgets/timerPicker.dart';

class CheckButtonCustomListRow extends StatefulWidget {
  final List<String> titles;
  final StudentModel student;
  final List daysSelected;
  final Map mapValuesClassTimes;
  // ignore: use_key_in_widget_constructors
  const CheckButtonCustomListRow(
      {required this.titles,
      required this.student,
      required this.daysSelected,
      required this.mapValuesClassTimes});

  @override
  State<CheckButtonCustomListRow> createState() =>
      _CheckButtonCustomListRowState();
}

class _CheckButtonCustomListRowState extends State<CheckButtonCustomListRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            children: List.generate(widget.titles.length, (index) {
          return CheckButtomCustom(
              daysSelected: widget.daysSelected,
              student: widget.student,
              mapValuesClassTimes: widget.mapValuesClassTimes,
              title: widget.titles[index],
              value: widget
                  .mapValuesClassTimes[widget.titles[index].toLowerCase()][0]
                  .toString());
        })),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class CheckButtomCustom extends StatefulWidget {
  final String title;
  final String value;
  final Map mapValuesClassTimes;
  final StudentModel student;
  final List daysSelected;
  const CheckButtomCustom(
      {Key? key,
      required this.title,
      required this.daysSelected,
      required this.value,
      required this.mapValuesClassTimes,
      required this.student})
      : super(key: key);
  @override
  State<CheckButtomCustom> createState() => _CheckButtomCustomState();
}

class _CheckButtomCustomState extends State<CheckButtomCustom> {
  late bool value;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  _convertDay(String day) {
    if (day == "seg") {
      return 2;
    } else if (day == "ter") {
      return 3;
    } else if (day == "qua") {
      return 4;
    } else if (day == "qui") {
      return 5;
    } else if (day == "sex") {
      return 6;
    } else if (day == "sab") {
      return 7;
    }
  }

  @override
  void initState() {
    value = widget.value == "true";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
        widget.title,
        style: Fonts.h5b,
      ),
      Checkbox(
          value: value,
          onChanged: (newValue) {
            setState(() {
              value = newValue!;
              widget.mapValuesClassTimes[widget.title.toLowerCase()][0] =
                  newValue;
              updateStatusCheckBox(widget.mapValuesClassTimes, widget.student)
                  .then((value) async {
                await flutterLocalNotificationsPlugin
                    .cancel(_convertDay(widget.title.toLowerCase()) + 100);
              });
              widget.daysSelected.add(widget.title.toLowerCase());
            });
          }),
    ]);
  }
}
