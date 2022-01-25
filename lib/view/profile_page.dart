import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/view/home_page.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'widgets/menus/customAppBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class ProfilePage extends StatefulWidget {
  final StudentModel student;
  const ProfilePage({Key? key, required this.student}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editable = false;
  String photo = "";
  bool loading = false;

  TextEditingController nameController = TextEditingController();
  late var photoChanged;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    editable = false;
    photo = widget.student.photo.toString();
    nameController.text = widget.student.name;
    photoChanged = null;
    loading = false;
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
        child: Form(
          key: _formKey,
          child: Column(children: [
            InkWell(
              onTap: () async {
                if (editable) {
                  await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              content: const Text("Escolha a fonte da imagem"),
                              actions: [
                                InkWell(
                                    child: const Text("Câmera"),
                                    onTap: () async {
                                      PickedFile? pickedFile =
                                          await StudentController()
                                              .selectInputImage("camera");
                                      setState(() {
                                        photo = pickedFile!.path;
                                        photoChanged = pickedFile;
                                      });
                                      Navigator.pop(context);
                                    }),
                                InkWell(
                                    child: const Text("Galeria"),
                                    onTap: () async {
                                      PickedFile? pickedFile =
                                          await StudentController()
                                              .selectInputImage("gallery");
                                      setState(() {
                                        photo = pickedFile!.path;
                                        photoChanged = pickedFile;
                                      });
                                      Navigator.pop(context);
                                    }),
                              ]));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: 170.0,
                height: 170.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(photo)),
                  boxShadow: [
                    editable == true
                        ? const BoxShadow(color: Colors.orange, spreadRadius: 4)
                        : const BoxShadow(
                            color: Colors.orange, spreadRadius: 0),
                  ],
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Preencha com seu Nome Completo';
                }
                return null;
              },
              controller: nameController,
              enabled: editable,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1),
                  ),
                  labelText: 'Nome Completo:',
                  icon: Icon(Icons.account_circle_outlined)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              enabled: false,
              initialValue: widget.student.email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Email:', icon: Icon(Icons.email)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              enabled: false,
              initialValue: widget.student.barcode,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Número:', icon: Icon(Icons.format_list_numbered)),
            ),
            const SizedBox(height: 20),
            editable == true
                ? buttonGerator(
                    backgroundColor: Colors.orange.shade200,
                    text: "Salvar Edição",
                    onClickFuncion: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          Loader.show(context,
                              progressIndicator:
                                  const LinearProgressIndicator());
                          //default

                          if (photoChanged != null) {
                            await StudentController().updateStudent(
                                widget.student.uid, nameController.text);
                            await StudentController().uploadProfilePicure(
                                widget.student.uid, photoChanged);
                          } else {
                            await StudentController().updateStudent(
                                widget.student.uid, nameController.text);
                          }

                          Loader.hide();

                          // confirma
                          await CoolAlert.show(
                              loopAnimation: false,
                              context: context,
                              type: CoolAlertType.success,
                              text: "Editado com Sucesso!!");
                          StudentModel studentAsModel =
                              await StudentController()
                                  .getStudentAsModel(widget.student.uid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(student: studentAsModel)));
                        } on Exception {
                          // erro
                          await CoolAlert.show(
                              loopAnimation: false,
                              context: context,
                              type: CoolAlertType.error,
                              text: "Erro!!");
                        }
                      }
                    })
                : const SizedBox(),
          ]),
        ),
      ),
    );
  }
}
