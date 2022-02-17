import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      imageQuality: 35,
      source: source,
    );
    return pickedFile;
  }

  Future<String> uploadProfilePicure(String uid, PickedFile pickedFile) async {
    String uploadedPhotoUrl = '';

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
        return value;
      });
    });

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

  Future<StudentModel> registerStudent(
      TimeClass classTimes,
      String uid,
      String name,
      String email,
      String photo,
      String barcode,
      String schoolLocation) async {
    StudentModel student = StudentModel(
        uid: uid,
        name: name,
        email: email,
        photo: photo.replaceAll('=s96-c', '=s400-c'),
        level: "student",
        barcode: barcode,
        schoolLocation: schoolLocation,
        classTimes: classTimes);
    print("------------------> passou aqui");
    print(student.classTimes?.seg.isEnable.toString());
    await FirebaseFirestore.instance.collection('students').doc(uid).set({
      'uid': student.uid,
      'name': student.name,
      'email': student.email,
      'photo': student.photo,
      'barcode': student.barcode,
      'level': student.level,
      'points': 0,
      'schoolLocation': student.schoolLocation,
      'classTimes': {
        'seg': [student.classTimes?.seg.isEnable, student.classTimes?.seg.time],
        'ter': [student.classTimes?.ter.isEnable, student.classTimes?.ter.time],
        'qua': [student.classTimes?.qua.isEnable, student.classTimes?.qua.time],
        'qui': [student.classTimes?.qui.isEnable, student.classTimes?.qui.time],
        'sex': [student.classTimes?.sex.isEnable, student.classTimes?.sex.time],
        'sab': [student.classTimes?.sab.isEnable, student.classTimes?.sab.time],
        'dom': [student.classTimes?.dom.isEnable, student.classTimes?.dom.time],
      },
    });
    print("------------------> passou aqui tmb2");

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
      student = StudentModel().jsonToObject(value.data());
    });
    return student;
  }

  Future<bool> addPointStudent(String barcode, String schoolLocation) async {
    bool res = false;
    await FirebaseFirestore.instance
        .collection('students')
        .where("barcode", isEqualTo: barcode)
        .where("schoolLocation", isEqualTo: schoolLocation)
        .get()
        .then((value) {
      for (var element in value.docs) {
        res = element.exists;
        FirebaseFirestore.instance
            .collection('students')
            .doc(element.data()["uid"])
            .update({
          'points': element.data()["points"] + 10,
        });
      }
    });
    return res;
  }

  Future<List<StudentModel>> getAllStudents(String schoolLocation) async {
    List<StudentModel> listStudents = [];
    var collectionRef = FirebaseFirestore.instance.collection('students');
    final allStudents = await collectionRef.get();
    for (int i = 0; i < allStudents.docs.length; i++) {
      StudentModel studentTemp =
          StudentModel().jsonToObject(allStudents.docs[i].data());
      if (studentTemp.schoolLocation != "all") {
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

Future<Map> getValuesClassTimes(StudentModel student) async {
  Map mapClassTimes = {};

  await FirebaseFirestore.instance
      .collection('students')
      .doc(student.uid)
      .get()
      .then((value) {
    mapClassTimes = Map.from(value.data()!["classTimes"]);
  });

  return mapClassTimes;
}

Future<bool> updateStatusCheckBox(
    Map mapClassTimes, StudentModel student) async {
  try {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(student.uid)
        .update({
      'classTimes': mapClassTimes,
    });
    return true;
  } on Exception {
    return false;
  }
}

Future<bool> updateClassTimes(Map mapClassTimes, StudentModel student) async {
  try {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(student.uid)
        .update({
      'classTimes': mapClassTimes,
    });
    return true;
  } on Exception {
    return false;
  }
}
