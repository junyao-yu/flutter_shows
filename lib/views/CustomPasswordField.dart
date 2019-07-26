import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomPasswordField extends StatelessWidget {
  String data;

  CustomPasswordField(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: CustomPaint(
        painter: PasswordFieldBox(this.data),
      ),
    );
  }
}

class PasswordFieldBox extends CustomPainter {
  final int length = 4;
  final int perSpace = 13;
  Paint normalBoxPaint = Paint();
  Paint selectBoxPaint = Paint();

  String data;

  PasswordFieldBox(this.data) {
    normalBoxPaint.color = Color(0xFFA7A7A7);
    normalBoxPaint.isAntiAlias = true;
    normalBoxPaint.strokeWidth = 1.0;
    normalBoxPaint.style = PaintingStyle.stroke;

    selectBoxPaint.color = Color(0xFFEA4C56);
    selectBoxPaint.isAntiAlias = true;
    selectBoxPaint.strokeWidth = 1.0;
    selectBoxPaint.style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int width = size.width.toInt() - perSpace * (length - 1);
    double per = width / 4;

    for (int i = 0; i < length; i++) {
      double left = (per + perSpace) * i;
      double right = per * (i + 1) + perSpace * i;

      RRect rRect =
          RRect.fromLTRBR(left, 0.0, right, per, Radius.circular(3.0));

      if (i < data.length) {
        canvas.drawRRect(rRect, selectBoxPaint);

        ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 27))
          ..pushStyle(ui.TextStyle(color: Color(0xFF4A4A4A)))
          ..addText(data[i]);
        ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: per);

        ui.Paragraph paragraph = pb.build()..layout(pc);
        canvas.drawParagraph(paragraph, Offset(left, (per - 27) / 2));
      } else {
        canvas.drawRRect(rRect, normalBoxPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
