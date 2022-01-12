import 'package:flutter/material.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/widgets/AppBar_and_SideBarMenu/customAppBar.dart';
import 'package:zipcursos_app/view/widgets/AppBar_and_SideBarMenu/mydrawer.dart';
import 'package:zipcursos_app/view/widgets/studentCard.dart';
import 'package:pagination_view/pagination_view.dart';

class RankingPage extends StatefulWidget {
  final StudentModel student;
  const RankingPage({Key? key, required this.student}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final Color colorGold = Colors.yellow.shade600;
  final Color colorBronze = Colors.brown.shade400;
  final Color colorSilver = Colors.grey.shade400;
  final Color colorGray = Colors.grey.shade50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: const <Widget>[
        SizedBox(child: Text("Zip Cursos Profissionalizantes"))
      ],
      appBar: MyAppBar(title: "Ranking Notas 10"),
      drawer: MyDrawer(student: widget.student),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text("Ranking de Alunos Nota 10", style: Fonts.h1b),
            Text("Escola Zip Cursos Profissionalizantes", style: Fonts.h3),
            const SizedBox(height: 10.0),
            Image.network("assets/nota_10.png", fit: BoxFit.fill),
            const SizedBox(height: 10.0),
            const Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Ouro:"),
                  Container(
                      width: 40.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                          color: colorGold, shape: BoxShape.rectangle)),
                  const Text("Prata:"),
                  Container(
                      width: 40.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                          color: colorBronze, shape: BoxShape.rectangle)),
                  const Text("Bronze:"),
                  Container(
                      width: 40.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                          color: colorSilver, shape: BoxShape.rectangle)),
                ]),
            const Divider(),
            StudentCardRow(student: widget.student, colorPodium: colorGold),
            StudentCardRow(student: widget.student, colorPodium: colorBronze),
            StudentCardRow(student: widget.student, colorPodium: colorSilver),
            StudentCardRow(student: widget.student, colorPodium: colorGray)
          ],
        ),
      ),
    );
  }
}
