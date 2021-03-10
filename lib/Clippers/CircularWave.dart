import 'package:flutter/material.dart';

/// Custom clipper for circular page reveal.
class CircularWave extends CustomClipper<Path> {
  final double revealPercent;
  final Size iconSize;
  final double verReveal;

  CircularWave(
    this.iconSize,
    this.revealPercent,
    this.verReveal,
  );

  @override
  Path getClip(Size size) {
    final center = Offset(
      size.width,
      size.height * verReveal,
    );
    final radius = 1000 * revealPercent + iconSize.width * 2;
    final diameter = 2 * radius;
    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    final rect = Rect.fromLTWH(
      center.dx - radius,
      center.dy - radius,
      diameter,
      diameter,
    );

    ///Adding Oval with path.addOval() Makes the clipper totally inverse
    ///So have to use addArc().It took me 3 hours to make this workaround, lol.
    ///try to use addOval instead, and u will find the issue
    path.addArc(rect, 90, -270);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
