import 'package:flutter/material.dart';
import 'package:liquid_swipe/Clippers/CircularWave.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/PageHelpers/page_dragger.dart';

import '../Clippers/WaveLayer.dart';

/// Internal Class
///
/// This Widget reveals the next page in the liquid wave form.
///
/// Required Parameters :
/// [horizontalReveal] Horizontal Reveal from [PageDragger]
/// [child] refers to the Next Page
/// [slideDirection] left to Right or Right to left or default none. see [SlideDirection]
/// [iconPosition] double type value. represents the percentage of the slide icon position vertically
/// [waveType] add currently available [WaveType]'s
/// [verticalReveal] Vertical Reveal from [PageDragger]
class PageReveal extends StatelessWidget {
  final double horizontalReveal;
  final Widget child;
  final SlideDirection? slideDirection;
  final Size iconSize;
  final WaveType waveType;
  final double verticalReveal;
  final bool enableSideReveal;

  ///Constructor for [PageReveal].
  PageReveal({
    required this.horizontalReveal,
    required this.child,
    this.slideDirection,
    required this.iconSize,
    required this.waveType,
    required this.verticalReveal,
    required this.enableSideReveal,
  });

  @override
  Widget build(BuildContext context) {
    switch (waveType) {
      case WaveType.circularReveal:
        return ClipPath(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          clipper: CircularWave(
            iconSize,
            slideDirection == SlideDirection.leftToRight
                ? 1.0 - horizontalReveal
                : horizontalReveal,
            verticalReveal,
          ),
          child: child,
        );
      default:
        return ClipPath(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          clipper: WaveLayer(
              revealPercent: slideDirection == SlideDirection.leftToRight
                  ? 1.0 - horizontalReveal
                  : horizontalReveal,
              slideDirection: slideDirection,
              iconSize: iconSize,
              verReveal: verticalReveal,
              enableSideReveal: enableSideReveal),
          child: child,
        );
    }
  }
}
