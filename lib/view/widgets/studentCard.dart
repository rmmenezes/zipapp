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
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
      child: Card(
        elevation: 10,
        color: Colors.blueGrey[50],
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  "https://logosmarcas.net/wp-content/uploads/2021/08/Android-Logo.png",
                  fit: BoxFit.cover,
                  height: 100.0,
                  width: 230.0),
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
  // ignore: prefer_const_constructors_in_immutables
  StudentCardRow(
      {Key? key, required this.student, this.colorPodium = Colors.greenAccent})
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
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.network(student.photoURL,
                    fit: BoxFit.cover, height: 80.0, width: 80.0),
                VerticalDivider(color: colorPodium),
                Column(
                  children: [
                    Text("Nome: " + student.name, style: Fonts.h2b),
                    Text("Número: " + student.barcode, style: Fonts.h3b),
                    Text("Pontos: " + student.barcode, style: Fonts.h4b),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
