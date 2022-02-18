import 'package:flutter/material.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/colors.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/widgets/barcode.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;

  const StudentCard({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
      child: Card(
        elevation: 10,
        color: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Image(
                  image: AssetImage("assets/logo_zip.jpg"), height: 100),
              student.level == "admin"
                  ? Text("PROFESSOR" + student.points.toString(),
                      style: Fonts.h5b)
                  : const SizedBox(),
              const SizedBox(height: 20),
              Image.network(student.photo,
                  fit: BoxFit.cover, height: 220.0, width: 220.0),
              const SizedBox(height: 10),
              Text(student.name,
                  overflow: TextOverflow.ellipsis, style: Fonts.h3b),
              BarCode(barcodeData: student.barcode)
            ]),
      ),
    );
  }
}

class StudentCardRow extends StatelessWidget {
  final StudentModel student;
  final Color colorPodium;
  int podiumPosition;
  // ignore: prefer_const_constructors_in_immutables
  StudentCardRow(
      {Key? key,
      required this.student,
      this.colorPodium = Colors.greenAccent,
      this.podiumPosition = -1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor colorBlueZip =
        MaterialColor(0xFF030281, CustomColors().colorBlueZip);
    return SizedBox(
      height: 100,
      child: Card(
        elevation: 2,
        color: colorPodium,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            const SizedBox(width: 10),
            podiumPosition > 0
                ? Row(children: [
                    Text(podiumPosition.toString() + "º", style: Fonts.h4b)
                  ])
                : const SizedBox(),
            const SizedBox(width: 10),
            Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(student.photo)),
                  borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                  color: colorBlueZip,
                )),
            VerticalDivider(color: colorPodium),
            Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student.name,
                        overflow: TextOverflow.ellipsis, style: Fonts.h3b),
                    Text("Número: " + student.barcode.toString(),
                        overflow: TextOverflow.ellipsis, style: Fonts.h4),
                    Text("Pontos: " + student.points.toString(),
                        overflow: TextOverflow.ellipsis, style: Fonts.h4),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
