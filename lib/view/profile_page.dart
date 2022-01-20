import 'dart:io';
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

  @override
  void initState() {
    editable = false;
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
              XFile? file;
              await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          content: const Text("Escolha a fonte da imagem"),
                          actions: [
                            InkWell(
                                child: const Text("Câmera"),
                                onTap: () async {
                                  file = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  Navigator.pop(context);
                                }),
                            InkWell(
                                child: const Text("Galeria"),
                                onTap: () async {
                                  file = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  Navigator.pop(context);
                                }),
                          ]));

              String a = await StudentController(
                      student: widget.student, f: File(file!.path))
                  .uploadProfilePicure();
              print(await a);
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
            enabled: editable,
            initialValue: widget.student.name,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: 'Nome Completo:',
                icon: Icon(Icons.account_circle_outlined)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            enabled: editable,
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
              ? buttonGerator(text: "Salvar Edição", onClickFuncion: () {})
              : const SizedBox(),
        ]),
      ),
    );
  }
}
