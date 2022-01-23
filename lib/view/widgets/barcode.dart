import 'package:flutter/cupertino.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:zipcursos_app/util/fonts.dart';

class BarCode extends StatelessWidget {
  final barcodeData;

  const BarCode({Key? key, this.barcodeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Center(
        child: Column(
          children: [
            BarCodeImage(
              params: Code39BarCodeParams(
                barcodeData,
                lineWidth: 4.0,
                barHeight: 80.0,
              ),
            ),
            Text(barcodeData, style: Fonts.h4b)
          ],
        ),
      ),
    );
  }
}
