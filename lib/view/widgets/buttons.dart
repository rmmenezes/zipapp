import 'package:flutter/material.dart';

class buttonGerator extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final Color backgroundColor;
  final Function() onClickFuncion;
  final Image? iconButton;
  final bool outlineButtonTheme;

  const buttonGerator({
    this.text = '',
    this.fontColor = Colors.black,
    this.fontSize = 18.0,
    this.backgroundColor = Colors.orange,
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
                color: backgroundColor,
                border: Border.all(color: backgroundColor, width: 2),
              )
            : BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: backgroundColor, width: 2),
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
