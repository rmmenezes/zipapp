import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zipcursos_app/models/student.dart';

class StudentController {
  Future<String> uploadProfilePicure(String uid, PickedFile pickedFile) async {
    String uploadedPhotoUrl = '';
    if (kIsWeb) {
      Reference _reference =
          FirebaseStorage.instance.ref().child("students/photos/" + uid);
      await _reference
          .putData(
        await pickedFile.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        await _reference.getDownloadURL().then((value) {
          uploadedPhotoUrl = value;
          return uploadedPhotoUrl;
        });
      });
    }
    await FirebaseFirestore.instance.collection('students').doc(uid).update({
      'photo': uploadedPhotoUrl,
    });
    return uploadedPhotoUrl;
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
      'points': 0,
    });
    return student;
  }

  Future<bool> updateStudent(String uid, String name) async {
    try {
      await FirebaseFirestore.instance.collection('students').doc(uid).update({
        'name': name,
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
        student.points = value.data()!["points"];
      });
      return student;
    } on Exception {
      return student;
    }
  }

  Future<bool> addPointStudent(String barcode) async {
    bool res = false;
    await FirebaseFirestore.instance
        .collection('students')
        .where("barcode", isEqualTo: barcode)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        res = element.exists;
        FirebaseFirestore.instance
            .collection('students')
            .doc(element.data()["uid"])
            .update({
          'points': element.data()["points"] + 10,
        });
      });
    });
    return res;
  }
}
