import 'package:flutter/material.dart';
import 'view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Zip Cursos',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          backgroundColor: Colors.white,
        ),
        home: new Container());
  }
}
