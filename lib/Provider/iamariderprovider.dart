import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/Helpers/slide_update.dart';
import 'package:liquid_swipe/PageHelpers/animated_page_dragger.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class IAmARiderProvider extends ChangeNotifier {
  SlideUpdate slideUpdate;
  AnimatedPageDragger animatedPageDragger;
  int activePageIndex = 0; //active page index
  int nextPageIndex = 0; //next page index
  SlideDirection slideDirection = SlideDirection.none; //slide direction
  double slidePercentHor, slidePercentVer = 0.0; //slide percentage (0.0 to 1.0)
  UpdateType prevUpdate;
  bool enableLoop = true;
  int pagesLength = 0;
  TickerProviderStateMixin singleTickerProviderStateMixin;
  double positionSlideIcon;
  OnPageChangeCallback _onPageChangeCallback;
  CurrentUpdateTypeCallback _currentUpdateTypeCallback;
  SlidePercentCallback _slidePercentCallback;
  bool isInProgress = false;

  bool _isAnimating = false; // true when animation is running
  bool shouldDisableUserGesture = false;

  IAmARiderProvider(
      int initialPage,
      bool loop,
      int length,
      TickerProviderStateMixin mixin,
      double slideIcon,
      OnPageChangeCallback onPageChangeCallback,
      CurrentUpdateTypeCallback currentUpdateTypeCallback,
      SlidePercentCallback slidePercentCallback,
      bool disableGesture) {
    slidePercentHor = slidePercentVer = 0.0;
    activePageIndex = initialPage;
    nextPageIndex = initialPage;
    enableLoop = loop;
    pagesLength = length;
    singleTickerProviderStateMixin = mixin;
    positionSlideIcon = slideIcon;
    _currentUpdateTypeCallback = currentUpdateTypeCallback;
    _onPageChangeCallback = onPageChangeCallback;
    _slidePercentCallback = slidePercentCallback;
    shouldDisableUserGesture = disableGesture;
  }

  /// Animating page to the mentioned page
  /// Known Issue : First we have to jump to the previous screen
  /// Not using for now
  animateDirectlyToPage(int page, int duration) {
    if (isInProgress || activePageIndex == page) return;
    isInProgress = true;
    activePageIndex = page - 1;
    nextPageIndex = page;
    if (activePageIndex < 0) {
      activePageIndex = 0;
      jumpToPage(page);
      return;
    }
    new Timer.periodic(const Duration(milliseconds: 1), (t) {
      if (t.tick < duration / 2) {
        updateSlide(SlideUpdate(SlideDirection.rightToLeft, t.tick / duration,
            1, UpdateType.dragging));
      } else if (t.tick < duration) {
        updateSlide(SlideUpdate(SlideDirection.rightToLeft, t.tick / duration,
            1, UpdateType.animating));
      } else {
        updateSlide(SlideUpdate(
            SlideDirection.rightToLeft, 1, 1, UpdateType.doneAnimating));
        t.cancel();
        isInProgress = false;
      }
    });
  }

  animateToPage(int page, int duration) {
    if (isInProgress || activePageIndex == page) return;
    isInProgress = true;
    int diff = 0;
    if (activePageIndex < page) {
      diff = page - activePageIndex;
      int newDuration = duration ~/ diff;
      new Timer.periodic(Duration(milliseconds: newDuration), (callback) {
        new Timer.periodic(const Duration(milliseconds: 1), (t) {
          if (t.tick < newDuration / 2) {
            updateSlide(SlideUpdate(SlideDirection.rightToLeft,
                t.tick / newDuration, 1, UpdateType.dragging));
          } else if (t.tick < newDuration) {
            updateSlide(SlideUpdate(SlideDirection.rightToLeft,
                t.tick / newDuration, 1, UpdateType.animating));
          } else {
            updateSlide(SlideUpdate(
                SlideDirection.rightToLeft, 1, 1, UpdateType.doneAnimating));
            t.cancel();
          }
        });
        if (callback.tick >= diff) {
          callback.cancel();
          isInProgress = false;
        }
      });
    } else {
      diff = activePageIndex - page;
      int newDuration = duration ~/ diff;
      new Timer.periodic(Duration(milliseconds: newDuration), (callback) {
        new Timer.periodic(const Duration(milliseconds: 1), (t) {
          if (t.tick < newDuration / 2) {
            updateSlide(SlideUpdate(SlideDirection.leftToRight,
                t.tick / newDuration, 1, UpdateType.dragging));
          } else if (t.tick < newDuration) {
            updateSlide(SlideUpdate(SlideDirection.leftToRight,
                t.tick / newDuration, 1, UpdateType.animating));
          } else {
            updateSlide(SlideUpdate(
                SlideDirection.leftToRight, 1, 1, UpdateType.doneAnimating));
            t.cancel();
          }
        });
        if (callback.tick >= diff) {
          callback.cancel();
          isInProgress = false;
        }
      });
    }
  }

  ///If no animation is required.
  jumpToPage(int page) {
    if (page == activePageIndex || isInProgress) return;
    if (activePageIndex == pagesLength - 1 && !enableLoop) {
      return;
    }
    isInProgress = true;
    activePageIndex = page - 1;
    nextPageIndex = page;
    if (nextPageIndex >= pagesLength) nextPageIndex = 0;
    updateSlide(SlideUpdate(
        SlideDirection.rightToLeft, 1, 0.5, UpdateType.doneAnimating));
    isInProgress = false;
  }

  updateSlide(SlideUpdate slidUpdate) {
    slideUpdate = slidUpdate;
    updateData(slidUpdate);
    notifyListeners();
  }

  updateData(SlideUpdate event) {
    if (prevUpdate != event.updateType && _currentUpdateTypeCallback != null)
      _currentUpdateTypeCallback(event.updateType);

    if (_slidePercentCallback != null &&
        event.updateType != UpdateType.doneAnimating) {
      String hor = (event.slidePercentHor * 100).toStringAsExponential(2);
      String ver = (event.slidePercentVer * 100).toStringAsExponential(2);
      _slidePercentCallback(
          double.parse(hor), (((double.parse(ver)) * 100) / 125));
    }

    prevUpdate = event.updateType;

    //if the user is dragging then
    if (event.updateType == UpdateType.dragging) {
      slideDirection = event.direction;
      slidePercentHor = event.slidePercentHor;
      slidePercentVer = event.slidePercentVer;

      // making pages to be in loop
      nextPageIndex = activePageIndex;
      if (enableLoop) {
        //conditions on slide direction
        if (slideDirection == SlideDirection.leftToRight) {
          nextPageIndex = activePageIndex - 1;
        } else if (slideDirection == SlideDirection.rightToLeft) {
          nextPageIndex = activePageIndex + 1;
        }

        if (nextPageIndex > pagesLength - 1) {
          nextPageIndex = 0;
        } else if (nextPageIndex < 0) {
          nextPageIndex = pagesLength - 1;
        }
        return;
      }

      //conditions on slide direction
      if (slideDirection == SlideDirection.leftToRight &&
          activePageIndex != 0) {
        nextPageIndex = activePageIndex - 1;
      } else if (slideDirection == SlideDirection.rightToLeft &&
          activePageIndex != pagesLength - 1) {
        nextPageIndex = activePageIndex + 1;
      }
      return;
    }
    //if the user has done dragging
    else if (event.updateType == UpdateType.doneDragging) {
      // slidepercent > 0.2 so that it wont reveal itself unless this condition is true
      if (slidePercentHor > 0.2) {
        isAnimating = true; // Page started to animate

        animatedPageDragger = AnimatedPageDragger(
          slideUpdateStream: this,
          slideDirection: slideDirection,
          transitionGoal: TransitionGoal.open,
          slidePercentHor: slidePercentHor,
          slidePercentVer: slidePercentVer,
          vsync: singleTickerProviderStateMixin,
        );
      } else {
        animatedPageDragger = AnimatedPageDragger(
          slideUpdateStream: this,
          slideDirection: slideDirection,
          transitionGoal: TransitionGoal.close,
          slidePercentHor: slidePercentHor,
          slidePercentVer: slidePercentVer,
          vsync: singleTickerProviderStateMixin,
        );

        nextPageIndex = activePageIndex;
      }
      //Run the animation
      animatedPageDragger.run();
      return;
    }
    //when animating
    else if (event.updateType == UpdateType.animating) {
      slideDirection = event.direction;
      slidePercentHor = event.slidePercentHor;
      slidePercentVer = event.slidePercentVer;
      return;
    }

    //done animating
    activePageIndex = nextPageIndex;
    if (_onPageChangeCallback != null) {
      _onPageChangeCallback(activePageIndex);
    }
    slideDirection = SlideDirection.none;
    slidePercentHor = 0.0;
    slidePercentVer = positionSlideIcon;

    isAnimating = false; // Page stopped animating
    return;
  }

  // Getter and setter for isAnimating
  set isAnimating(bool newValue) {
    this._isAnimating = newValue;
    notifyListeners();
  }

  bool get isAnimating => _isAnimating;

  set setUserGesture(bool disable) {
    this.shouldDisableUserGesture = disable;
    notifyListeners();
  }

  bool get isUserGestureDisabled => shouldDisableUserGesture;
}
