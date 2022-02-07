class StudentModel {
  String uid;
  String name;
  String email;
  String photo;
  String barcode;
  String level;
  String schoolLocation;
  int points;
  TimeClass? classTimes;

  StudentModel(
      {this.name = '',
      this.uid = '',
      this.email = '',
      this.photo = '',
      this.barcode = '',
      this.level = '',
      this.schoolLocation = '',
      this.points = 0,
      this.classTimes});

  StudentModel jsonToObject(param0) {
    StudentModel student = StudentModel();
    student.uid = param0["uid"];
    student.name = param0["name"];
    student.email = param0["email"];
    student.photo = param0["photo"];
    student.barcode = param0["barcode"];
    student.level = param0["level"];
    student.points = param0["points"];
    student.schoolLocation = param0["schoolLocation"];
    student.classTimes = TimeClass(
        // seg: param0["classTimes"]["seg"].toString(),
        // ter: param0["classTimes"]["ter"].toString(),
        // qua: param0["classTimes"]["qua"].toString(),
        // qui: param0["classTimes"]["qui"].toString(),
        // sex: param0["classTimes"]["sex"].toString(),
        // sab: param0["classTimes"]["sab"].toString(),
        // dom: param0["classTimes"]["dom"].toString(),
        );
    return student;
  }
}

class DayClass {
  bool isEnable;
  String time;

  DayClass({this.isEnable = false, this.time = "00:00"});
}

class TimeClass {
  DayClass seg = DayClass();
  DayClass ter = DayClass();
  DayClass qua = DayClass();
  DayClass qui = DayClass();
  DayClass sex = DayClass();
  DayClass sab = DayClass();
  DayClass dom = DayClass();

  TimeClass();
}
