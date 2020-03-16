import 'package:flutter/cupertino.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/Helpers/slide_update.dart';
import 'package:liquid_swipe/PageHelpers/animated_page_dragger.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class IAmARiderProvider extends ChangeNotifier {
  SlideUpdate slideUpdate;
  AnimatedPageDragger
      animatedPageDragger; //When user stops dragging then by using this page automatically drags.

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

  IAmARiderProvider(
      int initialPage,
      bool loop,
      int length,
      TickerProviderStateMixin mixin,
      double slideIcon,
      OnPageChangeCallback onPageChangeCallback,
      CurrentUpdateTypeCallback currentUpdateTypeCallback) {
    slidePercentHor = slidePercentVer = 0;
    activePageIndex = initialPage;
    nextPageIndex = initialPage;
    enableLoop = loop;
    pagesLength = length;
    singleTickerProviderStateMixin = mixin;
    positionSlideIcon = slideIcon;
    _currentUpdateTypeCallback = currentUpdateTypeCallback;
    _onPageChangeCallback = onPageChangeCallback;
  }

  updateSlide(SlideUpdate slidUpdate) {
    slideUpdate = slidUpdate;
    updateData(slidUpdate);
    notifyListeners();
  }

  updateData(SlideUpdate event) {
    if (prevUpdate != event.updateType && _currentUpdateTypeCallback != null)
      _currentUpdateTypeCallback(event.updateType);

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
    slidePercentHor = 0.5;
    slidePercentVer = positionSlideIcon;
    return;
  }
}
