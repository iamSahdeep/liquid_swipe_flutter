import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import '../liquid_swipe.dart';

/// This class provides the animation controller
/// used when then user stops dragging and page
/// reveal is not completed.

class AnimatedPageDragger {
  final SlideDirection slideDirection;

  //This variable tells that whether we have to open or close the page reveal.
  final TransitionGoal transitionGoal;

  //Animation controller
  AnimationController completionAnimationController;

  //Constructor
  AnimatedPageDragger({
    this.slideDirection,
    this.transitionGoal,
    double slidePercent,
    StreamController<SlideUpdate> slideUpdateStream,
    TickerProvider vsync,
  }) {
    final startSlidePercent = slidePercent;
    double endSlidePercent;
    Duration duration;

    //We have to complete the page reveal
    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;

      final slideRemaining = 1.0 - slidePercent;
      //Standard value take for drag velocity to avoid complex calculations.
      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    }
    //We have to close the page reveal
    else {
      endSlidePercent = 0.0;

      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }

    //Adding listener to animation controller
    //Also value to animation controller vary from 0.0 to 1.0 according to duration.
    completionAnimationController = AnimationController(
        duration: duration, vsync: vsync)
      ..addListener(() {
        final slidePercent = lerpDouble(startSlidePercent, endSlidePercent,
            completionAnimationController.value);

        //Adding to slide update stream
        slideUpdateStream.add(
            SlideUpdate(slideDirection, slidePercent, UpdateType.animating));
      })
      ..addStatusListener((AnimationStatus status) {
        //When animation has done executing
        if (status == AnimationStatus.completed) {
          //Adding to slide update stream
          slideUpdateStream.add(SlideUpdate(
              slideDirection, slidePercent, UpdateType.doneAnimating));
        }
      });
  }

  //This method is used to run animation Controller
  void run() {
    completionAnimationController.forward(from: 0.0);
  }

  //This method is used to dispose animation controller
  void dispose() {
    completionAnimationController.dispose();
  }
}
