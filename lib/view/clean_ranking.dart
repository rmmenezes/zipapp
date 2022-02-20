import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/colors.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'widgets/menus/customAppBar.dart';

class CleanRankingPage extends StatefulWidget {
  final StudentModel student;
  const CleanRankingPage({Key? key, required this.student}) : super(key: key);

  @override
  _CleanRankingPageState createState() => _CleanRankingPageState();
}

class _CleanRankingPageState extends State<CleanRankingPage> {
  late TextEditingController barcodeController = TextEditingController();
  var _selectedLocation;

  final List<String> _locations = [
    'Mirante do Paranapanema',
    'Presidente Bernardes'
  ]; // Option 2

  @override
  Widget build(BuildContext context) {
    MaterialColor colorBlueZip =
        MaterialColor(0xFF030281, CustomColors().colorBlueZip);
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: const <Widget>[
        SizedBox(child: Text("Zip Cursos Profissionalizantes"))
      ],
      appBar: MyAppBar(title: "Editar Ranking"),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text("Remover 10 pontos de um aluno", style: Fonts.h3b),
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
            onClickFuncion: () async {
              Loader.show(context,
                  progressIndicator: const LinearProgressIndicator());
              bool a = await StudentController().addPointStudent(
                  barcodeController.text, widget.student.schoolLocation);
              Loader.hide();
              if (a) {
                await CoolAlert.show(
                    loopAnimation: false,
                    context: context,
                    type: CoolAlertType.success,
                    text: "Limpo com Sucesso!!");
              } else {
                await CoolAlert.show(
                    loopAnimation: false,
                    context: context,
                    type: CoolAlertType.error,
                    text: "Aluno Não Cadastrado");
              }
            },
            text: "OK",
          ),
          const Divider(),
          Text("Limpar ranking por unidade", style: Fonts.h3b),
          DropdownButton(
            icon: const Icon(Icons.list),
            isExpanded: true,
            hint: const Text('Unidade'), // Not necessary for Option 1
            value: _selectedLocation,
            onChanged: (newValue) {
              setState(() {
                _selectedLocation = newValue;
              });
            },
            items: _locations.map((location) {
              return DropdownMenuItem(
                child: Text(location),
                value: location,
              );
            }).toList(),
          ),
          TextFormField(
            controller: barcodeController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: 'Senha de Liberação',
                icon: Icon(Icons.format_list_numbered)),
          ),
          const SizedBox(height: 20),
          buttonGerator(
            onClickFuncion: () async {
              Loader.show(context,
                  progressIndicator: const LinearProgressIndicator());
              bool a = await StudentController().addPointStudent(
                  barcodeController.text, widget.student.schoolLocation);
              Loader.hide();
              if (a) {
                await CoolAlert.show(
                    loopAnimation: false,
                    context: context,
                    type: CoolAlertType.success,
                    text: "Limpo com Sucesso!!");
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
