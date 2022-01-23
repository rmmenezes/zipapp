import 'package:flutter/material.dart';
import 'package:zipcursos_app/view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAUWSxDSGaxL57M4mlMm681dWI6A-qb3K4",
            authDomain: "rmba-8c14e.firebaseapp.com",
            projectId: "rmba-8c14e",
            storageBucket: "rmba-8c14e.appspot.com",
            messagingSenderId: "903308750260",
            appId: "1:903308750260:web:9de3eca7abff75f95d16e1",
            measurementId: "G-DJ823X2XTD"));
  } else {
    Firebase.app(); // if already initialized, use that one
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
        theme: ThemeData(
            primarySwatch: Colors.orange, backgroundColor: Colors.white),
        home: const LoginPage());
  }
}
