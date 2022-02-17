import 'package:flutter/material.dart';
import 'package:zipcursos_app/util/colors.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  MyAppBar({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor colorBlueZip =
        MaterialColor(0xFF030281, CustomColors().colorBlueZip);
    return Column(
      children: [
        AppBar(
          backgroundColor: colorBlueZip,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
