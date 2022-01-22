import 'dart:html';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'widgets/menus/customAppBar.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final StudentModel student;
  const ProfilePage({Key? key, required this.student}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editable = false;
  String photo =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Gull_portrait_ca_usa.jpg/300px-Gull_portrait_ca_usa.jpg";

  TextEditingController nameController = TextEditingController();
  late File file;

  @override
  void initState() {
    editable = false;
    nameController.text = widget.student.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: const <Widget>[
        SizedBox(child: Text("Zip Cursos Profissionalizantes"))
      ],
      appBar: MyAppBar(title: "Perfil"),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(children: [
          InkWell(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          content: const Text("Escolha a fonte da imagem"),
                          actions: [
                            InkWell(
                                child: const Text("Câmera"),
                                onTap: () async {
                                  File? f = (await ImagePicker().pickImage(
                                      source: ImageSource.camera)) as File?;
                                  Navigator.pop(context);
                                }),
                            InkWell(
                                child: const Text("Galeria"),
                                onTap: () async {
                                  File? f = (await ImagePicker().pickImage(
                                      source: ImageSource.gallery)) as File?;
                                  Navigator.pop(context);
                                }),
                          ]));
            },
            child: Container(
              width: 170.0,
              height: 170.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.student.photo)),
                borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                editable = !editable;
              });
            },
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 10),
                  Text("Editar")
                ]),
          ),
          const SizedBox(height: 40),
          TextFormField(
            controller: nameController,
            enabled: editable,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: 'Nome Completo:',
                icon: Icon(Icons.account_circle_outlined)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            enabled: false,
            initialValue: widget.student.email,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: 'Email:', icon: Icon(Icons.email)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            enabled: false,
            initialValue: widget.student.barcode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: 'Número:', icon: Icon(Icons.format_list_numbered)),
          ),
          const SizedBox(height: 20),
          editable == true
              ? buttonGerator(
                  text: "Salvar Edição",
                  onClickFuncion: () async {
                    try {
                      await StudentController().updateStudent(
                          widget.student.uid, nameController.text, photo);
                      // confirma
                      await CoolAlert.show(
                          loopAnimation: false,
                          context: context,
                          type: CoolAlertType.success,
                          text: "Editado com Sucesso!!");
                    } on Exception {
                      // erro
                      await CoolAlert.show(
                          loopAnimation: false,
                          context: context,
                          type: CoolAlertType.error,
                          text: "Erro!!");
                    }
                  })
              : const SizedBox(),
        ]),
      ),
    );
  }
}
