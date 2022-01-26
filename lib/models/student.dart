class StudentModel {
  String uid;
  String name;
  String email;
  String photo;
  String barcode;
  String level;
  int points;

  StudentModel({
    this.name = '',
    this.uid = '',
    this.email = '',
    this.photo = '',
    this.barcode = '',
    this.level = '',
    this.points = 0,
  });
}
