import 'package:flutter/material.dart';

class WaveLayer extends CustomPainter {
  double waveCenterY;
  double waveHorRadius;
  double waveVertRadius;
  double sideWidth;

  WaveLayer({
    @required this.waveCenterY,
    @required this.waveHorRadius,
    @required this.waveVertRadius,
    @required this.sideWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    var maskWidth = size.width - sideWidth;
    path.moveTo(maskWidth - sideWidth, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(maskWidth, size.height);
    double curveStartY = waveCenterY + waveVertRadius;

    path.lineTo(maskWidth, curveStartY);

    path.cubicTo(
        maskWidth,
        curveStartY - waveVertRadius * 0.1346194756,
        maskWidth - waveHorRadius * 0.05341339583,
        curveStartY - waveVertRadius * 0.2412779634,
        maskWidth - waveHorRadius * 0.1561501458,
        curveStartY - waveVertRadius * 0.3322374268);

    path.cubicTo(
        maskWidth - waveHorRadius * 0.2361659167,
        curveStartY - waveVertRadius * 0.4030805244,
        maskWidth - waveHorRadius * 0.3305285625,
        curveStartY - waveVertRadius * 0.4561193293,
        maskWidth - waveHorRadius * 0.5012484792,
        curveStartY - waveVertRadius * 0.5350576951);

    path.cubicTo(
        maskWidth - waveHorRadius * 0.515878125,
        curveStartY - waveVertRadius * 0.5418222317,
        maskWidth - waveHorRadius * 0.5664134792,
        curveStartY - waveVertRadius * 0.5650349878,
        maskWidth - waveHorRadius * 0.574934875,
        curveStartY - waveVertRadius * 0.5689655122);

    path.cubicTo(
        maskWidth - waveHorRadius * 0.7283715208,
        curveStartY - waveVertRadius * 0.6397387195,
        maskWidth - waveHorRadius * 0.8086618958,
        curveStartY - waveVertRadius * 0.6833456585,
        maskWidth - waveHorRadius * 0.8774032292,
        curveStartY - waveVertRadius * 0.7399037439);

    path.cubicTo(
        maskWidth - waveHorRadius * 0.9653464583,
        curveStartY - waveVertRadius * 0.8122605122,
        maskWidth - waveHorRadius,
        curveStartY - waveVertRadius * 0.8936183659,
        maskWidth - waveHorRadius,
        curveStartY - waveVertRadius);

    path.cubicTo(
        maskWidth - waveHorRadius,
        curveStartY - waveVertRadius * 1.100142878,
        maskWidth - waveHorRadius * 0.9595746667,
        curveStartY - waveVertRadius * 1.1887991951,
        maskWidth - waveHorRadius * 0.8608411667,
        curveStartY - waveVertRadius * 1.270484439);

    path.cubicTo(
        maskWidth - waveHorRadius * 0.7852123333,
        curveStartY - waveVertRadius * 1.3330544756,
        maskWidth - waveHorRadius * 0.703382125,
        curveStartY - waveVertRadius * 1.3795848049,
        maskWidth - waveHorRadius * 0.5291125625,
        curveStartY - waveVertRadius * 1.4665102805);

    path.cubicTo(
      maskWidth - waveHorRadius * 0.5241858333,
      curveStartY - waveVertRadius * 1.4689677195,
      maskWidth - waveHorRadius * 0.505739125,
      curveStartY - waveVertRadius * 1.4781625854,
      maskWidth - waveHorRadius * 0.5015305417,
      curveStartY - waveVertRadius * 1.4802616098,
    );

    path.cubicTo(
        maskWidth - waveHorRadius * 0.3187486042,
        curveStartY - waveVertRadius * 1.5714239024,
        maskWidth - waveHorRadius * 0.2332057083,
        curveStartY - waveVertRadius * 1.6204116463,
        maskWidth - waveHorRadius * 0.1541165417,
        curveStartY - waveVertRadius * 1.687403);

    path.cubicTo(
        maskWidth - waveHorRadius * 0.0509933125,
        curveStartY - waveVertRadius * 1.774752061,
        maskWidth,
        curveStartY - waveVertRadius * 1.8709256829,
        maskWidth,
        curveStartY - waveVertRadius * 2);

    path.lineTo(maskWidth, 0);
    path.close();
    canvas.drawPath(path, new Paint()..color = Colors.red..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
