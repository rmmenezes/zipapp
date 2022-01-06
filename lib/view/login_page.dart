// import 'dart:io';

// ignore_for_file: deprecated_member_use

// import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:zipcursos_app/controllers/auth.dart';
import 'package:zipcursos_app/view/widgets/buttons.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:load/load.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();
// DateTime currentBackPressTime;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  AuthFirebaseService AuthService = new AuthFirebaseService();

  //String _email;
  //String _password;
  //String _uid;
  //String _authHint = '';
  bool passwordVisible = true;

  //SharedPreferences sharedPreferences;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool checkValue = false;

  @override
  void initState() {
    super.initState();
    getCredential();
    passwordVisible = true;
  }

  // /// This mehtod makes the real auth
  // Future<FirebaseUser> firebaseAuthWithFacebook(
  //     {@required FacebookAccessToken token}) async {
  //   AuthCredential credential =
  //       FacebookAuthProvider.getCredential(accessToken: token.token);
  //   final AuthResult authResult = await _auth.signInWithCredential(credential);
  //   final FirebaseUser firebaseUser = authResult.user;
  //   return firebaseUser;
  // }

  // void initiateFacebookLogin() async {
  //   //This object comes from facebook_login_plugin package
  //   final facebookLogin = new FacebookLogin();

  //   final facebookLoginResult =
  //       await facebookLogin.logIn(['email', 'public_profile']);

  //   switch (facebookLoginResult.status) {
  //     case FacebookLoginStatus.error:
  //       print(facebookLoginResult.errorMessage);
  //       print("Error");
  //       break;

  //     case FacebookLoginStatus.cancelledByUser:
  //       print("CancelledByUser");
  //       break;

  //     case FacebookLoginStatus.loggedIn:
  //       showLoadingDialog();

  //       print("LoggedIn");

  //       /// calling the auth mehtod and getting the logged user
  //       var user = await firebaseAuthWithFacebook(
  //           token: facebookLoginResult.accessToken);
  //       print(user.uid.toString());
  //       setState(() {
  //         _authHint = 'Success\n\nUser id: ${user.uid.toString()}';
  //         _uid = user.uid.toString();
  //         sharedPreferences.setString("uid", _uid);
  //         var document = Firestore.instance.collection('alunos').document(_uid);
  //         document.get().then((datasnaoshot) {
  //           if (datasnaoshot.exists) {
  //             showLoadingDialog();
  //             Navigator.push(
  //               context,
  //               null,
  //             );
  //           } else {
  //             print("No such user");
  //             print(user.uid.toString());
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => new CreateRegisterPage(
  //                       user.email.toString(),
  //                       user.displayName.toString(),
  //                       user.uid.toString(),
  //                       "true")),
  //             );
  //           }
  //         });
  //       });
  //   }
  // }

  // void signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );

  //   final AuthResult authResult = await _auth.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;

  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);

  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);

  //   setState(() {
  //     _authHint = 'Success\n\nUser id: ${user.uid.toString()}';
  //     _uid = user.uid.toString();
  //     sharedPreferences.setString("uid", _uid);
  //     var document = Firestore.instance.collection('alunos').document(_uid);
  //     document.get().then((datasnaoshot) {
  //       if (datasnaoshot.exists) {
  //         showLoadingDialog();
  //         Navigator.push(
  //           context,
  //           null,
  //         );
  //       } else {
  //         print("No such user");
  //         print(user.uid.toString());
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => new CreateRegisterPage(
  //                   user.email.toString(),
  //                   user.displayName.toString(),
  //                   user.uid.toString(),
  //                   "true")),
  //         );
  //       }
  //     });
  //   });
  // }

  // void signOutGoogle() async {
  //   await googleSignIn.signOut();
  //   print("User Sign Out");
  // }

  // Future<bool> onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     Toast.show("Pressione novamente para sair", context,
  //         duration: Toast.LENGTH_SHORT,
  //         gravity: Toast.BOTTOM,
  //         backgroundRadius: 10);
  //     return Future.value(false);
  //   }
  //   FirebaseAuth.instance.signOut();
  //   exit(0);
  //   return Future.value(true);
  // }

  //_onChanged(bool value) async {
  //sharedPreferences = await SharedPreferences.getInstance();
  //setState(() {
  //checkValue = value;
  //sharedPreferences.setBool("check", checkValue);
  //sharedPreferences.setString("username", username.text);
  //sharedPreferences.setString("password", password.text);
  //getCredential();
  // });
  //}

  getCredential() async {
    //sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      //checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          //  username.text = sharedPreferences.getString("username");
          // password.text = sharedPreferences.getString("password");
        } else {
          username.clear();
          password.clear();
          //sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  //bool validateAndSave() {
  //final form = formKey.currentState;
  //if (form.validate()) {
  //form.save();
  //return true;
  //}
  //return false;
  //}

  // void validateAndSubmit() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   if (validateAndSave()) {
  //     try {
  //       showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return Center(child: CircularProgressIndicator());
  //           });
  //       final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
  //               email: _email, password: _password))
  //           .user;
  //       if (user.isEmailVerified) {
  //         setState(() {
  //           _authHint = 'Success\n\nUser id: ${user.uid.toString()}';
  //           _uid = user.uid.toString();
  //           // UID do usuario acessivel em qualquer tela, apartir do SharedPreferences
  //           sharedPreferences.setString("uid", _uid);
  //           Navigator.push(
  //             context,
  //             null,
  //           );
  //         });
  //       } else {
  //         Toast.show("Click no link de ativação na sua caixa de Email", context,
  //             duration: Toast.LENGTH_LONG,
  //             gravity: Toast.CENTER,
  //             backgroundRadius: 10);
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => LoginPage()));
  //       }
  //     } catch (e) {
  //       if (e.toString() ==
  //           'PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)') {
  //         setState(() {
  //           _authHint =
  //               "Não conseguimos encontrar nenhum usuário cadastrado com este Email. Certifique-se de que o Email informado esta correto.";
  //         });
  //       } else if (e.toString() ==
  //           "PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)") {
  //         setState(() {
  //           _authHint =
  //               "Não foi possível. Verifique sua conexão com a Internet.";
  //         });
  //       }
  //     }
  //   } else {
  //     setState(() {
  //       _authHint = '';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);

    final emailField = TextFormField(
      controller: username,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0))),
      //validator: (value) =>
      //  value.isEmpty ? 'O campo Email não pode ser vazio' : null,
      //  onSaved: (value) => _email = value,
    );

    final passwordField = TextFormField(
      controller: password,
      obscureText: passwordVisible,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          hintText: "Senha",
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0))),
      //validator: (value) =>
      //  value.isEmpty ? 'O campo Senha não pode ser vazio.' : null,
      //onSaved: (value) => _password = value,
    );

    final loginButon = Material(
      elevation: 1.0,
      color: Colors.orange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onLongPress: null,
        // onPressed: validateAndSubmit,
        onPressed: () {},
        child:
            Text("Logar com Email", textAlign: TextAlign.center, style: style),
      ),
    );

    final loginGoogle = Material(
      elevation: 1.0,
      color: Colors.grey[100],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        // onPressed: () {
        //   signInWithGoogle();
        // },
        onLongPress: null,
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google.png"), height: 22.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Logar com o Google', style: style),
            )
          ],
        ),
      ),
    );

    final loginFacebook = Material(
      elevation: 1.0,
      color: Colors.grey[100],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        // onPressed: () {
        //   initiateFacebookLogin();
        // },
        onLongPress: null,
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/facebook.png"), height: 22.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Logar com o Facebook', style: style),
            )
          ],
        ),
      ),
    );

    final buildHintText = Text("_authHint",
        key: new Key('hint'),
        style: new TextStyle(fontSize: 18.0, color: Colors.red),
        textAlign: TextAlign.center);

    final createRegister = FlatButton(
      onPressed: () {},
      child: Text("CRIAR MINHA CONTA",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.grey[400])),
      // onPressed: () {
      // Navigator.push(
      // context,
      // MaterialPageRoute(
      //   builder: (context) =>
      // CreateRegisterPage("", "", "", "false")),
      // );
      //},
    );

    final resetPassword = FlatButton(
      onPressed: () {},
      child: Text("Esqueceu a senha?",
          textAlign: TextAlign.left,
          style: style.copyWith(
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
              fontSize: 15)),
      //onPressed: () {
      // Navigator.push(
      //  context,
      // MaterialPageRoute(builder: (context) => //ResetPassword()
      //),
      //);
      //},
    );

    // final rememberMe = Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: <Widget>[
    //       Row(
    //         children: <Widget>[
    //           Checkbox(value: checkValue, onChanged: nulldependOnInheritedWidgetOfExactType
    //               //onChanged: _onChanged,
    //               ),
    //           Text(
    //             "Salvar",
    //             style: style,
    //           ),
    //         ],
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: <Widget>[resetPassword],
    //       ),
    //     ]);

    return WillPopScope(
        onWillPop: null,
        // onWillPop: onWillPop,
        child: Scaffold(
            backgroundColor: Colors.white,
            persistentFooterButtons: <Widget>[
              SizedBox(child: Text("Zip Cursos Profissionalizantes"))
            ],
            appBar: new AppBar(
              title: new Text('', textAlign: TextAlign.center),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: new Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 150.0,
                            child: Image.asset(
                              "assets/logo_zip.jpg",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          buttonGerator(
                              onClickFuncion: AuthService.signInwithGoogle,
                              text: 'Logar com o Google',
                              backgroundColor: Colors.grey[100],
                              iconButton: Image(
                                  image: AssetImage("assets/google.png"),
                                  height: 22.0)),
                          SizedBox(height: 10),
                          buttonGerator(
                              text: 'Logar com o Facebook',
                              backgroundColor: Colors.grey[100],
                              iconButton: Image(
                                  image: AssetImage("assets/facebook.png"),
                                  height: 22.0)),
                          SizedBox(height: 6.5),
                          buttonGerator(
                              onClickFuncion: () {
                                showDialog(
                                    context: context,
                                    builder: (ctxt) => new AlertDialog(
                                          title: Text("Text Dialog"),
                                        ));
                              },
                              text: 'Logar com Email e Senha',
                              backgroundColor: Colors.grey[100],
                              iconButton: Image(
                                  image: AssetImage("assets/email.png"),
                                  height: 22.0)),
                          Row(children: <Widget>[
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                            ),
                            Text("OU"),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                            ),
                          ]),
                          SizedBox(height: 6.5),
                          emailField,
                          SizedBox(height: 10.0),
                          passwordField,
                          //   rememberMe,
                          loginButon,
                          SizedBox(height: 10.0),
                          createRegister,
                          buildHintText
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
