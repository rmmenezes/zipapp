import 'package:flutter/material.dart';
import 'package:zipcursos_app/view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    print("WEB");
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDoWsYndGj8N7Jm1JGTkbNyj0GFBkmitU4",
            authDomain: "zipapp-7953c.firebaseapp.com",
            projectId: "zipapp-7953c",
            storageBucket: "zipapp-7953c.appspot.com",
            messagingSenderId: "1039712499767",
            appId: "1:1039712499767:web:c39b7e0da91ea64cd1a7b2",
            measurementId: "G-1V7PEYN6DJ"));
  } else {
    print("MOB");

    await Firebase.initializeApp();
  }

 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zip Cursos',
        theme:  ThemeData(
            primarySwatch: Colors.blue, backgroundColor: Colors.red)
,        home: const LoginPage());
  }
}
