class StudentModel {
  String name;
  String email;
  String photoURL;
  String barcode;

  StudentModel({
    required this.name,
    this.email = '',
    this.photoURL = '',
    this.barcode = '',
  });
}
