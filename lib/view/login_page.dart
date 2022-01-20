import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zipcursos_app/controllers/auth.dart';
import 'package:zipcursos_app/models/student.dart';
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
    bool _isSigningIn;
    return WillPopScope(
        onWillPop: null,
        // onWillPop: onWillPop,
        child: Scaffold(
            backgroundColor: Colors.white,
            persistentFooterButtons: const <Widget>[
              SizedBox(child: Text("Zip Cursos Profissionalizantes"))
            ],
            appBar: AppBar(title: const Text('', textAlign: TextAlign.center)),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 150.0,
                          child: Image.asset("assets/logo_zip.jpg",
                              fit: BoxFit.contain)),
                      const SizedBox(height: 15.0),
                      buttonGerator(
                          onClickFuncion: () async {
                            setState(() {
                              _isSigningIn = true;
                            });
                            User? user = await Authentication.signInWithGoogle(
                                context: context);
                            setState(() {
                              _isSigningIn = false;
                            });
                            if (user != null) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            student: StudentModel(
                                                uid: user.uid,
                                                name:
                                                    user.displayName.toString(),
                                                email: user.email.toString(),
                                                photoURL:
                                                    user.photoURL.toString(),
                                                barcode: "01260"),
                                          )));
                            }
                          },
                          text: 'Logar com o Google',
                          backgroundColor: Colors.grey.shade100,
                          iconButton: const Image(
                              image: AssetImage("assets/google.png"),
                              height: 22.0)),
                      const SizedBox(height: 10),
                      buttonGerator(
                          onClickFuncion: () {},
                          text: 'Logar com o Facebook',
                          backgroundColor: Colors.grey.shade100,
                          iconButton: const Image(
                              image: AssetImage("assets/facebook.png"),
                              height: 22.0)),
                      const SizedBox(height: 6.5),
                      buttonGerator(
                          onClickFuncion: () {
                            showDialog(
                                context: context,
                                builder: (ctxt) => const AlertDialog(
                                    title: Text("Text Dialog")));
                          },
                          text: 'Logar com Email e Senha',
                          backgroundColor: Colors.grey.shade100,
                          iconButton: const Image(
                              image: AssetImage("assets/email.png"),
                              height: 22.0)),
                    ],
                  ),
                ),
              ),
            )));
  }
}
