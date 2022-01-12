import 'package:flutter/material.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/fonts.dart';

import '../../ranking_page.dart';

class MyDrawer extends StatelessWidget {
  final StudentModel student;
  const MyDrawer({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              height: 125.0,
              color: Colors.orange,
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
            title: const Text('Ranking'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RankingPage(student: student)))
            },
          ),
        ],
      ),
    );
  }
}
