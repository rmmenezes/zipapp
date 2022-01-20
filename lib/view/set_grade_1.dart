import 'package:flutter/material.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'widgets/menus/customAppBar.dart';

class SetGrade10Page extends StatefulWidget {
  const SetGrade10Page({Key? key}) : super(key: key);

  @override
  _SetGrade10PageState createState() => _SetGrade10PageState();
}

class _SetGrade10PageState extends State<SetGrade10Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: const <Widget>[
        SizedBox(child: Text("Zip Cursos Profissionalizantes"))
      ],
      appBar: MyAppBar(title: "Marcar Nota 10"),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(children: [
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: 'Número:', icon: Icon(Icons.format_list_numbered)),
          ),
          const SizedBox(height: 20),
          buttonGerator(
            onClickFuncion: () {
              CoolAlert.show(
                  loopAnimation: false,
                  context: context,
                  type: CoolAlertType.success,
                  text: "Registrado com Sucesso!!");
            },
            text: "OK",
          )
        ]),
      ),
    );
  }
}
