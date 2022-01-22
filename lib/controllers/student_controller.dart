import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zipcursos_app/models/student.dart';

class StudentController {
  Future<String> uploadProfilePicure(String uid, File file) async {
    await FirebaseStorage.instance.ref().child("students/photos/$uid").delete();
    var taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("students/photos/$uid")
        .putFile(file);
    var imageUrl = await (taskSnapshot).ref.getDownloadURL();
    return imageUrl.toString();
  }

  Future<bool> checkIfUserExist(User user) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('students');
      var doc = await collectionRef.doc(user.uid).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  Future<StudentModel> registerStudent(String uid, String name, String email,
      String photo, String barcode) async {
    StudentModel student = StudentModel(
        uid: uid, name: name, email: email, photo: photo, barcode: barcode);
    await FirebaseFirestore.instance.collection('students').doc(uid).set({
      'uid': student.uid,
      'name': student.name,
      'email': student.email,
      'photo': student.photo,
      'barcode': student.barcode,
    });
    return student;
  }

  Future<bool> updateStudent(String uid, String name, String photo) async {
    try {
      await FirebaseFirestore.instance.collection('students').doc(uid).update({
        'name': name,
        'photo': photo,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<StudentModel> getStudentAsModel(User user) async {
    StudentModel student = StudentModel();
    try {
      var collectionRef = FirebaseFirestore.instance.collection('students');
      await collectionRef.doc(user.uid).get().then((value) {
        student.uid = value.data()!["uid"];
        student.name = value.data()!["name"];
        student.email = value.data()!["email"];
        student.photo = value.data()!["photo"];
        student.barcode = value.data()!["barcode"];
      });
      return student;
    } on Exception {
      return student;
    }
  }
}
