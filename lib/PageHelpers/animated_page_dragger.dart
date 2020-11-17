import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/Helpers/slide_update.dart';
import 'package:liquid_swipe/Provider/LiquidProvider.dart';

/// Internal Class
///
/// This class provides the animation controller
/// used when user stops dragging and page
/// reveal is not completed.
class AnimatedPageDragger {
  ///SlideDirection LTR, RTL or none
  final SlideDirection slideDirection;

  ///Current transition goal, either close the page or reveal it
  final TransitionGoal transitionGoal;

  ///Animation controller for Completing the Animation when user is Done with dragging
  AnimationController completionAnimationController;

  ///Constructor
  AnimatedPageDragger({
    this.slideDirection,
    this.transitionGoal,
    double slidePercentVer,
    double slidePercentHor,
    @required LiquidProvider slideUpdateStream,
    TickerProvider vsync,
  }) {
    final startSlidePercentHor = slidePercentHor;
    final startSlidePercentVer = slidePercentVer;
    double endSlidePercentHor, endSlidePercentVer;
    Duration duration;

    //We have to complete the page reveal
    if (transitionGoal == TransitionGoal.open) {
      endSlidePercentHor = 1.0;

      endSlidePercentVer = slideUpdateStream.positionSlideIcon;

      final slideRemaining = 1.0 - slidePercentHor;
      //Standard value take for drag velocity to avoid complex calculations.
      duration = Duration(
        milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round(),
      );
    }
    //We have to close the page reveal
    else {
      endSlidePercentHor = endSlidePercentVer = 0.0;

      duration = Duration(
        milliseconds: (slidePercentHor / PERCENT_PER_MILLISECOND).round(),
      );
    }

    //Adding listener to animation controller
    //Also value to animation controller vary from 0.0 to 1.0 according to duration.
    completionAnimationController = AnimationController(
      duration: duration,
      vsync: vsync,
    )
      ..addListener(() {
        final slidePercent = lerpDouble(
          startSlidePercentHor,
          endSlidePercentHor,
          completionAnimationController.value,
        );
        final slidePercentVer = lerpDouble(
          startSlidePercentVer,
          endSlidePercentVer,
          completionAnimationController.value,
        );
        //Adding to slide update stream
        slideUpdateStream.updateSlide(SlideUpdate(
          slideDirection,
          slidePercent,
          slidePercentVer,
          UpdateType.animating,
        ));
      })
      ..addStatusListener((AnimationStatus status) {
        //When animation has done executing
        if (status == AnimationStatus.completed) {
          //Adding to slide update stream
          slideUpdateStream.updateSlide(SlideUpdate(
            slideDirection,
            slidePercentHor,
            slidePercentVer,
            UpdateType.doneAnimating,
          ));
        }
      });
  }

  ///This method is used to run animation Controller in forward
  void run() {
    completionAnimationController.forward(from: 0.0);
  }

  ///This method is used to dispose animation controller
  void dispose() {
    completionAnimationController.dispose();
  }
}
