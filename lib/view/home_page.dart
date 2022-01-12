import 'package:flutter/material.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/view/widgets/AppBar_and_SideBarMenu/customAppBar.dart';
import 'package:zipcursos_app/view/widgets/AppBar_and_SideBarMenu/mydrawer.dart';
import 'package:zipcursos_app/view/widgets/studentCard.dart';

class HomePage extends StatefulWidget {
  final StudentModel student;
  const HomePage({Key? key, required this.student}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        persistentFooterButtons: const <Widget>[
          SizedBox(child: Text("Zip Cursos Profissionalizantes"))
        ],
        appBar: MyAppBar(title: "Página Inicial"),
        drawer: MyDrawer(student: widget.student),
        body: StudentCard(student: widget.student));
  }
}
