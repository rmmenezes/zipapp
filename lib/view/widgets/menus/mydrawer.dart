import 'package:flutter/material.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/colors.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/clean_ranking.dart';
import 'package:zipcursos_app/view/home_page.dart';
import 'package:zipcursos_app/view/profile_page.dart';
import '../../notify_class.dart';
import '../../ranking_page.dart';
import '../../set_grade_1.dart';

class MyDrawer extends StatelessWidget {
  final StudentModel student;
  const MyDrawer({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor colorBlueZip =
        MaterialColor(0xFF030281, CustomColors().colorBlueZip);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              height: 125.0,
              color: colorBlueZip,
              child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Stack(children: <Widget>[
                    Positioned(
                      bottom: 12.0,
                      left: 10.0,
                      child: Row(children: [
                        const Icon(Icons.account_circle,
                            color: Colors.white, size: 50),
                        const SizedBox(width: 10),
                        Column(children: [
                          Text("Zip Cursos",
                              style: Fonts.h4b.copyWith(color: Colors.white)),
                          Text(
                            "Profissionalizantes",
                            style: Fonts.h4
                                .copyWith(color: Colors.white.withOpacity(0.7)),
                          ),
                        ]),
                      ]),
                    ),
                  ]))),
          ListTile(
            leading: const Icon(Icons.dashboard_rounded),
            title: const Text('Home'),
            onTap: () async {
              StudentModel studentAsModel =
                  await StudentController().getStudentAsModel(student.uid);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(student: studentAsModel)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_rounded),
            title: const Text('Perfil'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(student: student)))
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_rounded),
            title: const Text('Ranking'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RankingPage(student: student)))
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_rounded),
            title: const Text('Lembrete'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotifyClass(student: student)))
            },
          ),
          student.level == "admin"
              ? ListTile(
                  leading: const Icon(Icons.dashboard_rounded),
                  title: const Text("Marcar Nota 10"),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SetGrade10Page(student: student)))
                  },
                )
              : const SizedBox(),
          // ListTile(
          //   leading: const Icon(Icons.dashboard_rounded),
          //   title: const Text('Limpar Ranking'),
          //   onTap: () => {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => CleanRankingPage(student: student)))
          //   },
          // ),
        ],
      ),
    );
  }
}
