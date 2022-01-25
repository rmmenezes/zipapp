import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/view/home_page.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'widgets/menus/customAppBar.dart';

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
  late var photoChanged;
  bool isConfirmPasswordVisible = false;
  String photo =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Gull_portrait_ca_usa.jpg/300px-Gull_portrait_ca_usa.jpg";

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();

  @override
  void initState() {
    if (widget.photo != null) {
      nameController.text = widget.nome!;
      emailController.text = widget.email!;
      photo = widget.photo!;
    }
    super.initState();
  }

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
              onTap: () async {
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
            const SizedBox(height: 40),
            TextFormField(
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
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Email:', icon: Icon(Icons.email)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(4)],
              controller: barcodeController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Número:', icon: Icon(Icons.format_list_numbered)),
            ),
            const SizedBox(height: 20),
            buttonGerator(
                text: "Confirmar Cadastro",
                onClickFuncion: () async {
                  try {
                    // registra
                    StudentModel student;
                    if (photoChanged != null) {
                      student = await StudentController().registerStudent(
                          widget.uid.toString(),
                          nameController.text,
                          emailController.text,
                          "",
                          barcodeController.text);
                      await StudentController()
                          .uploadProfilePicure(student.uid, photoChanged);
                    } else {
                      student = await StudentController().registerStudent(
                          widget.uid.toString(),
                          nameController.text,
                          emailController.text,
                          photo,
                          barcodeController.text);
                    }
                    // confirma
                    await CoolAlert.show(
                        loopAnimation: false,
                        context: context,
                        type: CoolAlertType.success,
                        text: "Registrado com Sucesso!!");
                    // go home page
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(student: student)));
                  } on Exception {
                    await CoolAlert.show(
                        loopAnimation: false,
                        context: context,
                        type: CoolAlertType.error,
                        text: "Erro!!");
                  }
                })
          ]),
        ));
  }
}
