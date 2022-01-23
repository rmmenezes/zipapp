import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'widgets/menus/customAppBar.dart';

class SetGrade10Page extends StatefulWidget {
  const SetGrade10Page({Key? key}) : super(key: key);

  @override
  _SetGrade10PageState createState() => _SetGrade10PageState();
}

class _SetGrade10PageState extends State<SetGrade10Page> {
  late TextEditingController barcodeController = TextEditingController();
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
            controller: barcodeController,
            inputFormatters: [LengthLimitingTextInputFormatter(4)],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: 'Número:', icon: Icon(Icons.format_list_numbered)),
          ),
          const SizedBox(height: 20),
          buttonGerator(
            backgroundColor: Colors.orange.shade200,
            onClickFuncion: () async {
              bool a = await StudentController()
                  .addPointStudent(barcodeController.text);
              if (a) {
                await CoolAlert.show(
                    loopAnimation: false,
                    context: context,
                    type: CoolAlertType.success,
                    text: "Registrado com Sucesso!!");
              } else {
                await CoolAlert.show(
                    loopAnimation: false,
                    context: context,
                    type: CoolAlertType.error,
                    text: "Aluno Não Cadastrado");
              }
            },
            text: "OK",
          )
        ]),
      ),
    );
  }
}
