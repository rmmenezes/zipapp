class StudentModel {
  String uid;
  String name;
  String email;
  String photo;
  String barcode;
  String level;
  String schoolLocation;
  int points;

  StudentModel({
    this.name = '',
    this.uid = '',
    this.email = '',
    this.photo = '',
    this.barcode = '',
    this.level = '',
    this.schoolLocation = '',
    this.points = 0,
  });
}
