import 'package:flutter/material.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/fonts.dart';
import 'package:zipcursos_app/view/widgets/barcode.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;

  const StudentCard({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
              const Image(
                image: AssetImage("assets/logo_zip.jpg"),
                height: 100,
              ),
              const SizedBox(height: 50),
              Image.network(student.photoURL,
                  fit: BoxFit.cover, height: 200.0, width: 200.0),
              const SizedBox(height: 10),
              Text(student.name, style: Fonts.h1b),
              const SizedBox(height: 15),
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
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(student.photoURL)),
                  borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                  color: Colors.redAccent,
                )),
            VerticalDivider(color: colorPodium),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(student.name, style: Fonts.h2b),
              Text("Pontos: " + student.barcode, style: Fonts.h4),
            ]),
          ]),
        ),
      ),
    );
  }
}
