import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/util/classDays.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';

class ListTimesAlerts extends StatefulWidget {
  final int index;
  final snapshot;
  final student;
  const ListTimesAlerts(
      {Key? key,
      required this.index,
      required this.snapshot,
      required this.student})
      : super(key: key);

  @override
  State<ListTimesAlerts> createState() => _ListTimesAlertsState();
}

class _ListTimesAlertsState extends State<ListTimesAlerts> {
  TimeOfDay _time = TimeOfDay.now().replacing(hour: 10, minute: 30);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  _lembrete(String hh, String mm, String dayOfWeek) async {
    var time = Time(int.parse(hh), int.parse(mm), 0);
    var code = _convertDayExtra(dayOfWeek);
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        code + 100,
        "Zip Cursos - Lembrete",
        "Sua aula iniciara em breve, contamos com sua presença",
        _convertDay(dayOfWeek),
        time,
        platformChannelSpecifics);
  }

  _initialisation() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    InitializationSettings initializationSettings =
        const InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<dynamic> selectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return const AlertDialog(
          title: Text("Zip Cursos - Lembrete"),
          content:
              Text("Sua aula iniciara em breve, contamos com sua presença."),
        );
      },
    );
  }

  _convertDayExtra(String day) {
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

  Day _convertDay(String day) {
    if (day == "seg") {
      return Day.monday;
    } else if (day == "ter") {
      return Day.tuesday;
    } else if (day == "qua") {
      return Day.wednesday;
    } else if (day == "qui") {
      return Day.thursday;
    } else if (day == "sex") {
      return Day.friday;
    } else {
      return Day.saturday;
    }
  }

  @override
  void initState() {
    super.initState();

    _initialisation();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 2,
        child: Text(
          ClassDays()
              .convertDayAbrvToFull(ClassDays().classDaysAbrv[widget.index]),
          style: Fonts.h4,
        ),
      ),
      Expanded(
          flex: 3,
          child: buttonGerator(
              fontColor: Colors.white,
              fontSize: 17,
              text: widget
                  .snapshot
                  .data!["classTimes"]
                      [ClassDays().classDaysAbrv[widget.index].toLowerCase()][1]
                  .toString(),
              onClickFuncion: () {
                Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: _time,
                    onChange: (newValue) {
                      setState(() {
                        _time = newValue;
                        var temp = widget.snapshot.data!["classTimes"];
                        temp[ClassDays().classDaysAbrv[widget.index].toString()]
                                [1] =
                            _time.hour.toString().padLeft(2, '0') +
                                ":" +
                                _time.minute.toString().padLeft(2, '0');

                        updateClassTimes(temp, widget.student).then((value) {
                          _lembrete(
                              _time.hour.toString(),
                              _time.minute.toString(),
                              ClassDays()
                                  .classDaysAbrv[widget.index]
                                  .toLowerCase());
                        });
                      });
                    },
                    is24HrFormat: true,
                  ),
                );
              })),
    ]);
  }
}
