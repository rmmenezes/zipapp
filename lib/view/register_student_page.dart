import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/colors.dart';
import 'package:zipcursos_app/view/home_page.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'widgets/menus/customAppBar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RegisterStudentPage extends StatefulWidget {
  String? nome;
  String? email;
  String? photo;
  String? uid;

  RegisterStudentPage({
    Key? key,
    this.nome = "",
    this.email = "",
    this.uid = "",
    this.photo = "",
  }) : super(key: key);
  @override
  _RegisterStudentPageState createState() => _RegisterStudentPageState();
}

class _RegisterStudentPageState extends State<RegisterStudentPage> {
  // ignore: prefer_typing_uninitialized_variables
  late var photoChanged;
  bool isConfirmPasswordVisible = false;
  String photo =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Gull_portrait_ca_usa.jpg/300px-Gull_portrait_ca_usa.jpg";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController schoolLocationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.photo != null) {
      nameController.text = widget.nome!;
      emailController.text = widget.email!;
      photoChanged = null;
      photo = widget.photo!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor colorBlueZip =
        MaterialColor(0xFF030281, CustomColors().colorBlueZip);
    return Scaffold(
        backgroundColor: Colors.white,
        persistentFooterButtons: const <Widget>[
          SizedBox(child: Text("Zip Cursos Profissionalizantes"))
        ],
        appBar: MyAppBar(title: "Registro"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                InkWell(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                content:
                                    const Text("Escolha a fonte da imagem"),
                                actions: [
                                  InkWell(
                                      child: const Text("C??mera"),
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
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: 170.0,
                    height: 170.0,
                    decoration: BoxDecoration(
                      image: photoChanged != null && kIsWeb == false
                          ? DecorationImage(
                              fit: BoxFit.cover, image: FileImage(File(photo)))
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  photo.replaceAll('=s96-c', '=s400-c'))),
                      boxShadow: [
                        BoxShadow(color: colorBlueZip, spreadRadius: 4)
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha com seu Nome Completo';
                    }
                    return null;
                  },
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      labelText: 'Nome Completo:',
                      icon: Icon(Icons.account_circle_outlined)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  enabled: false,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      labelText: 'Email:', icon: Icon(Icons.email)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Preencha com seu n??mero da Zip';
                    }
                    return null;
                  },
                  controller: barcodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4)
                  ],
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      labelText: 'N??mero:',
                      icon: Icon(Icons.format_list_numbered)),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Localiza????o da Unidade:',
                      icon: Icon(Icons.location_on)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha com o local da sua escola';
                    }
                    return null;
                  },
                  hint: const Text('Selecione a cidade da sua escola'),
                  items: <String>[
                    'Mirante do Paranapanema',
                    'Presidente Bernardes'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      schoolLocationController.text = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                buttonGerator(
                    text: "Confirmar Cadastro",
                    onClickFuncion: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          Loader.show(context,
                              progressIndicator:
                                  const LinearProgressIndicator());
                          // registra
                          StudentModel student;
                          TimeClass tc = TimeClass();
                          if (photoChanged != null) {
                            student = await StudentController().registerStudent(
                                tc,
                                widget.uid.toString(),
                                nameController.text,
                                emailController.text,
                                "",
                                barcodeController.text,
                                schoolLocationController.text);
                            await StudentController()
                                .uploadProfilePicure(student.uid, photoChanged);
                          } else {
                            student = await StudentController().registerStudent(
                                tc,
                                widget.uid.toString(),
                                nameController.text,
                                emailController.text,
                                photo,
                                barcodeController.text,
                                schoolLocationController.text);
                          }

                          Loader.hide();
                          // confirma
                          await CoolAlert.show(
                              loopAnimation: false,
                              context: context,
                              type: CoolAlertType.success,
                              text: "Registrado com Sucesso!!");
                          // go home page
                          StudentModel studentAsModel =
                              await StudentController()
                                  .getStudentAsModel(student.uid);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(student: studentAsModel)));
                        } on Exception {
                          await CoolAlert.show(
                              loopAnimation: false,
                              context: context,
                              type: CoolAlertType.error,
                              text: "Erro!!");
                        }
                      }
                    })
              ]),
            ),
          ),
        ));
  }
}
