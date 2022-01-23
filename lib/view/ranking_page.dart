import 'package:flutter/material.dart';
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
  List<StudentModel> items = [
    StudentModel(
        name: "Rafael Menezes",
        photo:
            "https://livecoins.com.br/wp-content/uploads/2021/09/Bitcoin-100k.jpg",
        email: "ra29fa@gmail.com",
        barcode: "1010"),
    StudentModel(
        name: "Rafael Menezes",
        photo:
            "https://livecoins.com.br/wp-content/uploads/2021/09/Bitcoin-100k.jpg",
        email: "ra29fa@gmail.com",
        barcode: "1010"),
    StudentModel(
        name: "Rafael Menezes",
        photo:
            "https://livecoins.com.br/wp-content/uploads/2021/09/Bitcoin-100k.jpg",
        email: "ra29fa@gmail.com",
        barcode: "1010"),
    StudentModel(
        name: "Rafael Menezes",
        photo:
            "https://livecoins.com.br/wp-content/uploads/2021/09/Bitcoin-100k.jpg",
        email: "ra29fa@gmail.com",
        barcode: "1010"),
    StudentModel(
        name: "Rafael Menezes",
        photo:
            "https://livecoins.com.br/wp-content/uploads/2021/09/Bitcoin-100k.jpg",
        email: "ra29fa@gmail.com",
        barcode: "1010"),
    StudentModel(
        name: "Rafael Menezes",
        photo:
            "https://livecoins.com.br/wp-content/uploads/2021/09/Bitcoin-100k.jpg",
        email: "ra29fa@gmail.com",
        barcode: "1010"),
    StudentModel(
        name: "Rafael Menezes",
        photo:
            "https://livecoins.com.br/wp-content/uploads/2021/09/Bitcoin-100k.jpg",
        email: "ra29fa@gmail.com",
        barcode: "1010"),
  ];

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
            Image.network("/assets/nota_10.png", fit: BoxFit.fill),
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
            ListStudentsRankingCardsRow(items: items),
          ],
        ),
      ),
    );
  }
}
