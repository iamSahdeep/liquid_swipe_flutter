import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import '../WaveLayer.dart';

/// This class reveals the next page in the liquid wave form.

class PageReveal extends StatelessWidget {
  final double revealPercent;
  final Widget child;
  final SlideDirection slideDirection;
  final double iconPosition;

  //Constructor
  PageReveal({
    this.revealPercent,
    this.child,
    this.slideDirection,
    this.iconPosition
  });

  @override
  Widget build(BuildContext context) {
    //ClipPath clips our Container (page) with clipper based on path..
    return new ClipPath(
      clipper: new WaveLayer(
          revealPercent: slideDirection == SlideDirection.leftToRight
              ? 1.0 - revealPercent
              : revealPercent,
          slideDirection: slideDirection,
          iconPosition: iconPosition),
      child: child,
    );
  }
}
