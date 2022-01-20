class StudentModel {
  String uid;
  String name;
  String email;
  String photoURL;
  String barcode;

  StudentModel({
    required this.name,
    this.uid = '',
    this.email = '',
    this.photoURL = '',
    this.barcode = '',
  });
}
