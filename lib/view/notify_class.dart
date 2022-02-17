import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/classDays.dart';
import 'package:zipcursos_app/util/colors.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'package:zipcursos_app/view/widgets/checkbox.dart';
import 'package:zipcursos_app/view/widgets/menus/customAppBar.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifyClass extends StatefulWidget {
  final StudentModel student;
  const NotifyClass({Key? key, required this.student}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotifyClass();
}

class _NotifyClass extends State<NotifyClass> {
  late Map mapValuesClassTimes = {};
  late List daysSelected = [];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<bool> _initPage() async {
    await _mapear();
    await _getDaysSelected(mapValuesClassTimes);
    return true;
  }

  Future<Map> _mapear() {
    Future<Map> m = getValuesClassTimes(widget.student)
        .then((value) => mapValuesClassTimes = value);
    return m;
  }

  Future<List> _getDaysSelected(Map mapValuesClassTimes) async {
    List _daysSelected = [];
    for (var day in ClassDays().classDaysAbrv) {
      if (mapValuesClassTimes[day][0].toString() == "true") {
        _daysSelected.add(day);
      }
    }
    setState(() {
      daysSelected = _daysSelected;
    });
    return _daysSelected;
  }

  void selectNotification(String? payload) async {
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

  _initialisation() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/launcher_icon");
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

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

  _lembrete(String hh, String mm, String dayOfWeek) async {
    DateTime time =
        DateTime(0, 0, 0, int.parse(hh), int.parse(mm), int.parse("0"), 0, 0);
    var _time = Time(time.hour, time.minute, time.second);
    var day = Day(_convertDay(dayOfWeek));
    var code = _convertDay(dayOfWeek);
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'show weekly channel id', 'show weekly channel name');
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        int.parse(code.toString()),
        'Zip Cursos - Lembrete',
        'Sua aula iniciara em breve, contamos com sua presença.',
        day,
        _time,
        platformChannelSpecifics);
  }

  @override
  void initState() {
    _initialisation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor colorBlueZip =
        MaterialColor(0xFF030281, CustomColors().colorBlueZip);
    return Scaffold(
        backgroundColor: Colors.white,
        persistentFooterButtons: const <Widget>[
          SizedBox(child: Text("Zip Cursos Profissionalizantes"))
        ],
        appBar: MyAppBar(title: "Notificação das Aulas"),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: FutureBuilder(
                  future: _mapear(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: Column(children: [
                          const Text("Minhas Aulas",
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 18.0)),
                          const SizedBox(height: 15),
                          Text(
                              "Podemos lhe avisar de suas aulas. Selecione os dias da semana e o horário desejados para enviarmos uma notificação.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  color: Colors.blue[900])),
                          const SizedBox(height: 15.0),
                          CheckButtonCustomListRow(
                            student: widget.student,
                            daysSelected: daysSelected,
                            mapValuesClassTimes: mapValuesClassTimes,
                            titles: ClassDays().classDaysAbrv,
                          ),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("students")
                                  .doc(widget.student.uid)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                      children: List.generate(
                                          ClassDays().classDaysAbrv.length,
                                          (index) {
                                    TimeOfDay _time = TimeOfDay.now()
                                        .replacing(hour: 10, minute: 30);

                                    return snapshot
                                                .data!["classTimes"][ClassDays()
                                                    .classDaysAbrv[index]][0]
                                                .toString() ==
                                            "true"
                                        ? Row(children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ClassDays()
                                                    .convertDayAbrvToFull(
                                                        ClassDays()
                                                                .classDaysAbrv[
                                                            index]),
                                                style: Fonts.h4,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: buttonGerator(
                                                    fontColor: Colors.white,
                                                    fontSize: 17,
                                                    text: snapshot
                                                        .data!["classTimes"][
                                                            ClassDays()
                                                                .classDaysAbrv[
                                                                    index]
                                                                .toLowerCase()]
                                                            [1]
                                                        .toString(),
                                                    onClickFuncion: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        showPicker(
                                                          context: context,
                                                          value: _time,
                                                          onChange: (newValue) {
                                                            setState(() {
                                                              _time = newValue;
                                                              var temp = snapshot
                                                                      .data![
                                                                  "classTimes"];
                                                              temp[ClassDays()
                                                                      .classDaysAbrv[
                                                                          index]
                                                                      .toString()]
                                                                  [1] = _time
                                                                      .hour
                                                                      .toString()
                                                                      .padLeft(
                                                                          2,
                                                                          '0') +
                                                                  ":" +
                                                                  _time.minute
                                                                      .toString()
                                                                      .padLeft(
                                                                          2,
                                                                          '0');

                                                              updateClassTimes(
                                                                      temp,
                                                                      widget
                                                                          .student)
                                                                  .then(
                                                                      (value) {
                                                                _lembrete(
                                                                    _time.hour
                                                                        .toString(),
                                                                    _time.minute
                                                                        .toString(),
                                                                    ClassDays()
                                                                        .classDaysAbrv[
                                                                            index]
                                                                        .toLowerCase());
                                                              });
                                                            });
                                                          },
                                                          is24HrFormat: true,
                                                        ),
                                                      );
                                                    })),
                                          ])
                                        : const SizedBox();
                                  }));
                                } else {
                                  return const Text("Loading...");
                                }
                              }),
                        ]),
                      );
                    } else {
                      return const Text("Loading");
                    }
                  })),
        ));
  }
}
