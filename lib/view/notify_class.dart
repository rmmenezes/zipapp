import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/classDays.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'package:zipcursos_app/view/widgets/checkbox.dart';
import 'package:zipcursos_app/view/widgets/menus/customAppBar.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';

class NotifyClass extends StatefulWidget {
  final StudentModel student;
  const NotifyClass({Key? key, required this.student}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotifyClass();
}

class _NotifyClass extends State<NotifyClass> {
  late Map mapValuesClassTimes = {};
  late List daysSelected = [];

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

  @override
  Widget build(BuildContext context) {
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
                                  fontFamily: 'Montserrat', fontSize: 23.0)),
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
                                        .replacing(hour: 11, minute: 30);

                                    return snapshot
                                                .data!["classTimes"][ClassDays()
                                                    .classDaysAbrv[index]][0]
                                                .toString() ==
                                            "true"
                                        ? Row(children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(ClassDays()
                                                  .convertDayAbrvToFull(
                                                      ClassDays().classDaysAbrv[
                                                          index])),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: buttonGerator(
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
                                                                      .toString() +
                                                                  ":" +
                                                                  _time.minute
                                                                      .toString();

                                                              updateClassTimes(
                                                                  temp,
                                                                  widget
                                                                      .student);
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
