import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zipcursos_app/models/student.dart';

class StudentController {
  late File f;
  late StudentModel student;

  StudentController({required this.f, required this.student});

  Future<String> uploadProfilePicure() async {
    try {
      var taskSnapshot = await FirebaseStorage.instance
          .ref()
          .child("user/profile/${student.uid}")
          .putFile(f);
      var imageUrl = await (taskSnapshot).ref.getDownloadURL();
      return imageUrl.toString();
    } catch (e) {
      return "";
    }
  }

  Future<void> updateURLProfilePicure() async {
    
  }
}
