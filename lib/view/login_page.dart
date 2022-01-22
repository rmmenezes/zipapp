import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zipcursos_app/controllers/auth.dart';
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/register_student_page.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: null,
        // onWillPop: onWillPop,
        child: Scaffold(
            backgroundColor: Colors.white,
            persistentFooterButtons: const <Widget>[
              SizedBox(child: Text("Zip Cursos Profissionalizantes"))
            ],
            appBar: AppBar(title: const Text('', textAlign: TextAlign.center)),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200.0,
                        child: Image.asset("assets/logo_zip.jpg",
                            fit: BoxFit.contain)),
                    const SizedBox(height: 30.0),
                    // const Divider(),
                    Text("Escola Zip Cursos Profissionalizantes",
                        style: Fonts.h1b),
                    const SizedBox(height: 15.0),
                    Text("Mirante do Paranapanema/SP", style: Fonts.h2),
                    Text("Rua Sebastião Farias da Costa, 1342 - Centro",
                        style: Fonts.h4),
                    Text("(18) 99742-7015 | @zipcursos", style: Fonts.h4),

                    const SizedBox(width: 400, child: Divider(height: 30)),
                    Text("Presidente Bernades/SP", style: Fonts.h2),
                    Text("Rua Sebastião Farias da Costa, 1342 - Centro",
                        style: Fonts.h4),
                    Text("(18) 99742-7015 | @zipcursospb", style: Fonts.h4),
                    const SizedBox(height: 30.0),

                    SizedBox(
                      width: 400,
                      child: buttonGerator(
                          onClickFuncion: () async {
                            // logar
                            User? user =
                                await Authentication.signInWithGoogle(
                                    context: context);
                            // verifica se logou
                            if (user != null) {
                              // se existe o usuario envia o usuario para a Home
                              if (await StudentController()
                                  .checkIfUserExist(user)) {
                                StudentModel student =
                                    await StudentController()
                                        .getStudentAsModel(user);

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(student: student)));
                              } else {
                                // se nao existe o usuario envia o usuario para registo
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterStudentPage(
                                                nome: user.displayName,
                                                email: user.email,
                                                photo: user.photoURL,
                                                uid: user.uid)));
                              }
                            }
                          },
                          text: 'Login com Google',
                          backgroundColor: Colors.orange.shade200,
                          iconButton: const Image(
                              image: AssetImage("assets/google.png"),
                              height: 22.0)),
                    ),
                  ],
                ),
              ),
            )));
  }
}