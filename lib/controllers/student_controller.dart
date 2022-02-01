import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zipcursos_app/models/student.dart';

class StudentController {
  Future<PickedFile?> selectInputImage(String input) async {
    ImageSource source;
    if (input == "camera") {
      source = ImageSource.camera;
    } else {
      source = ImageSource.gallery;
    }
    PickedFile? pickedFile = await ImagePicker().getImage(
      imageQuality: 70,
      source: source,
    );
    return pickedFile;
  }

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
      String photo, String barcode, String schoolLocation) async {
    StudentModel student = StudentModel(
        uid: uid,
        name: name,
        email: email,
        photo: photo,
        level: "student",
        barcode: barcode,
        schoolLocation: schoolLocation);
    await FirebaseFirestore.instance.collection('students').doc(uid).set({
      'uid': student.uid,
      'name': student.name,
      'email': student.email,
      'photo': student.photo,
      'barcode': student.barcode,
      'level': student.level,
      'points': 0,
      'schoolLocation': student.schoolLocation
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

  Future<StudentModel> getStudentAsModel(String uid) async {
    StudentModel student = StudentModel();

    var collectionRef = FirebaseFirestore.instance.collection('students');
    await collectionRef.doc(uid).get().then((value) {
      student.uid = value.data()!["uid"];
      student.name = value.data()!["name"];
      student.email = value.data()!["email"];
      student.photo = value.data()!["photo"];
      student.barcode = value.data()!["barcode"];
      student.level = value.data()!["level"];
      student.points = value.data()!["points"];
      student.schoolLocation = value.data()!["schoolLocation"];
    });
    return student;
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

  Future<List<StudentModel>> getAllStudents(String schoolLocation) async {
    List<StudentModel> listStudents = [];
    var collectionRef = FirebaseFirestore.instance.collection('students');
    final allStudents = await collectionRef.get();
    for (int i = 0; i < allStudents.docs.length; i++) {
      StudentModel studentTemp = StudentModel();
      studentTemp.uid = allStudents.docs[i].data()["uid"];
      studentTemp.name = allStudents.docs[i].data()["name"];
      studentTemp.email = allStudents.docs[i].data()["email"];
      studentTemp.photo = allStudents.docs[i].data()["photo"];
      studentTemp.barcode = allStudents.docs[i].data()["barcode"];
      studentTemp.level = allStudents.docs[i].data()["level"];
      studentTemp.points = allStudents.docs[i].data()["points"];
      studentTemp.schoolLocation = allStudents.docs[i].data()["schoolLocation"];
      if (schoolLocation != "all") {
        if (studentTemp.schoolLocation == schoolLocation) {
          listStudents.add(studentTemp);
        }
      } else {
        listStudents.add(studentTemp);
      }
    }
    return listStudents;
  }

  Future<List<StudentModel>> getAllStudentsOrdenByPoints(
      String schoolLocation) async {
    List<StudentModel> listStudents = await getAllStudents(schoolLocation);
    listStudents.sort((a, b) => b.points.compareTo(a.points));
    return listStudents;
  }
}
