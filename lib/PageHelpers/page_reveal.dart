import 'package:flutter/material.dart';
import 'package:liquid_swipe/Clippers/CircularWave.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';

import '../Clippers/WaveLayer.dart';

/// This class reveals the next page in the liquid wave form.

class PageReveal extends StatelessWidget {
  final double revealPercent;
  final Widget child;
  final SlideDirection slideDirection;
  final double iconPosition;
  final WaveType waveType;
  final double vertReveal;

  //Constructor
  PageReveal({
    this.revealPercent,
    this.child,
    this.slideDirection,
    this.iconPosition,
    this.waveType,
    this.vertReveal,
  });

  @override
  Widget build(BuildContext context) {
    //ClipPath clips our Container (page) with clipper based on path..
    if (waveType == WaveType.circularReveal) {
      return ClipPath(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        clipper: CircularWave(
          iconPosition,
          slideDirection == SlideDirection.leftToRight
              ? 1.0 - revealPercent
              : revealPercent,
          vertReveal,
        ),
        child: child,
      );
    }

    return ClipPath(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      clipper: WaveLayer(
        revealPercent: slideDirection == SlideDirection.leftToRight
            ? 1.0 - revealPercent
            : revealPercent,
        slideDirection: slideDirection,
        iconPosition: iconPosition,
        verReveal: vertReveal,
      ),
      child: child,
    );
  }
}
