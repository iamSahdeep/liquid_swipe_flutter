import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/Constants/constants.dart';

class WaveLayer extends CustomClipper<Path> {
  double revealPercent;
  double waveCenterY;
  double waveHorRadius;
  double waveVertRadius;
  double sideWidth;
  SlideDirection slideDirection;

  WaveLayer({
    @required this.revealPercent,
    @required this.slideDirection,
  });

  @override
  getClip(Size size) {
    Path path = new Path();
    sideWidth = sidewidth(size);
    waveVertRadius = waveVertRadiusF(size);
    waveCenterY = size.height * 0.75;
    if (slideDirection == SlideDirection.leftToRight) {
      waveHorRadius = waveHorRadiusFBack(size);
    } else {
      waveHorRadius = waveHorRadiusF(size);
    }
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

    return path;
  }

  double sidewidth(Size size) {
    var p1 = 0.2;
    var p2 = 0.8;
    if (revealPercent <= p1) {
      return 15.0;
    }
    if (revealPercent >= p2) {
      return size.width;
    }
    return 15.0 + (size.width - 15.0) * (revealPercent - p1) / (p2 - p1);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }

  double waveVertRadiusF(Size size) {
    var p1 = 0.4;
    if (revealPercent <= 0) {
      return 82.0;
    }
    if (revealPercent >= p1) {
      return size.height * 0.9;
    }
    return 82.0 + ((size.height * 0.9) - 82.0) * revealPercent / p1;
  }

  double waveHorRadiusF(Size size) {
    if (revealPercent <= 0) {
      return 48;
    }
    if (revealPercent >= 1) {
      return 0;
    }
    var p1 = 0.4;
    if (revealPercent <= p1) {
      return 48.0 + revealPercent / p1 * ((size.width * 0.8) - 48.0);
    }
    var t = (revealPercent - p1) / (1.0 - p1);
    var A = size.width * 0.8;
    var r = 40;
    var m = 9.8;
    var beta = r / (2 * m);
    var k = 50;
    var omega0 = k / m;
    var omega = pow(-pow(beta, 2) + pow(omega0, 2), 0.5);

    return A * exp(-beta * t) * cos(omega * t);
  }

  double waveHorRadiusFBack(Size size) {
    if (revealPercent <= 0) {
      return 48;
    }
    if (revealPercent >= 1) {
      return 0;
    }
    var p1 = 0.4;
    if (revealPercent <= p1) {
      return 48.0 + revealPercent / p1 * 48.0;
    }
    var t = (revealPercent - p1) / (1.0 - p1);
    var A = 96;
    var r = 40;
    var m = 9.8;
    var beta = r / (2 * m);
    var k = 50;
    var omega0 = k / m;
    var omega = pow(-pow(beta, 2) + pow(omega0, 2), 0.5);

    return A * exp(-beta * t) * cos(omega * t);
  }
}
