import 'package:flutter/material.dart';
import 'package:zipcursos_app/util/colors.dart';

class buttonGerator extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final Function() onClickFuncion;
  final Image? iconButton;
  final bool outlineButtonTheme;

  const buttonGerator({
    this.text = '',
    this.fontColor = Colors.white,
    this.fontSize = 18.0,
    required this.onClickFuncion,
    this.iconButton,
    this.outlineButtonTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontFamily: 'Montserrat', fontSize: fontSize, color: fontColor);

    return InkWell(
      onTap: onClickFuncion,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: outlineButtonTheme == false
            ? BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: MaterialColor(0xFF030281, CustomColors().colorBlueZip),
                border: Border.all(
                    color:
                        MaterialColor(0xFF030281, CustomColors().colorBlueZip),
                    width: 2),
              )
            : BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                    color:
                        MaterialColor(0xFF030281, CustomColors().colorBlueZip),
                    width: 2),
              ),
        child: Row(
          mainAxisAlignment: iconButton != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: <Widget>[
            Text(text, style: textStyle),
            if (iconButton != null)
              SizedBox(height: 25, width: 25, child: iconButton),
          ],
        ),
      ),
    );
  }
}
