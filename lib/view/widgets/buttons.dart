import 'dart:ui';
import 'package:flutter/material.dart';

class buttonGerator extends StatelessWidget {
  final String text;
  final Color fontColor;
  final double fontSize;
  final Color backgroundColor;
  final Function() onClickFuncion;
  final Icon iconButton;
  final outlineButtonTheme;
  final double width;
  final double height;

  const buttonGerator({
    @required this.text,
    this.fontColor = Colors.black,
    this.fontSize = 20.0,
    this.backgroundColor = Colors.orange,
    this.onClickFuncion,
    this.iconButton,
    this.outlineButtonTheme = false,
    this.width,
    this.height,
  }) {
    // TODO: implement
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Fonts.h4.copyWith(
      fontSize: fontSize,
      color: fontColor,
    );

    return InkWell(
      onTap: onClickFuncion,
      child: Container(
        height: width,
        width: width == null ? MediaQuery.of(context).size.width : width,
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: outlineButtonTheme == false
            ? BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: backgroundColor,
          border: Border.all(color: backgroundColor, width: 2),
        )
            : BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: backgroundColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: iconButton != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: <Widget>[
            Text(text, style: textStyle),
            if (iconButton != null) iconButton,
          ],
        ),
      ),
    );
  }
}