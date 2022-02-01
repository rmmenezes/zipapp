import 'package:flutter/material.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/colors.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/widgets/lists/listStudentsRankingCardsRow.dart';
import 'package:zipcursos_app/view/widgets/menus/customAppBar.dart';
import 'package:zipcursos_app/view/widgets/menus/mydrawer.dart';

class RankingPage extends StatefulWidget {
  final StudentModel student;
  const RankingPage({Key? key, required this.student}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  late Future<List<StudentModel>> studentsSortedByPoints;

  @override
  initState() {
    super.initState();
    studentsSortedByPoints = StudentController()
        .getAllStudentsOrdenByPoints(widget.student.schoolLocation);
  }

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
            const Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("Ouro:"),
                  Container(
                      width: 40.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                          color: CustomColors().colorGold,
                          shape: BoxShape.rectangle)),
                  const Text("Bronze:"),
                  Container(
                      width: 40.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                          color: CustomColors().colorBronze,
                          shape: BoxShape.rectangle)),
                  const Text("Prata:"),
                  Container(
                      width: 40.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                          color: CustomColors().colorSilver,
                          shape: BoxShape.rectangle)),
                ]),
            const Divider(),
            ListStudentsRankingCardsRow(items: studentsSortedByPoints),
          ],
        ),
      ),
    );
  }
}
