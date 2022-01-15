import 'package:flutter/material.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'widgets/menus/customAppBar.dart';
import 'widgets/menus/mydrawer.dart';

class RegisterStudentPage extends StatefulWidget {
  StudentModel student;
  RegisterStudentPage({Key? key, required this.student}) : super(key: key);
  @override
  _RegisterStudentPageState createState() => _RegisterStudentPageState();
}

class _RegisterStudentPageState extends State<RegisterStudentPage> {
  bool isConfirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        persistentFooterButtons: const <Widget>[
          SizedBox(child: Text("Zip Cursos Profissionalizantes"))
        ],
        appBar: MyAppBar(title: "Registro"),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(children: [
            InkWell(
              onTap: () {
                print("object");
              },
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.student.photoURL)),
                  borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                  color: Colors.redAccent,
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              initialValue: widget.student.name,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Nome Completo:',
                  icon: Icon(Icons.account_circle_outlined)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: widget.student.email,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Email:', icon: Icon(Icons.email)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: widget.student.barcode,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Número:', icon: Icon(Icons.format_list_numbered)),
            ),
            const SizedBox(height: 20),
            buttonGerator(text: "Confirmar Cadastro", onClickFuncion: () {})
          ]),
        ));
  }
}
