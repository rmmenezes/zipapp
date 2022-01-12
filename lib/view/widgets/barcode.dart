import 'package:flutter/cupertino.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:zipcursos_app/util/fonts.dart';

class BarCode extends StatelessWidget {
  final barcodeData;

  const BarCode({Key? key, this.barcodeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Center(
        child: BarcodeWidget(
          style: Fonts.h4b,
          barcode: Barcode.code128(),
          data: barcodeData, // Content
          width: 350,
          height: 120,
        ),
      ),
    );
  }
}
