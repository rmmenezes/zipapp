class StudentModel {
  String uid;
  String name;
  String email;
  String photo;
  String barcode;
  int points;

  StudentModel({
    this.name = '',
    this.uid = '',
    this.email = '',
    this.photo = '',
    this.barcode = '',
    this.points = 0,
  });
}
