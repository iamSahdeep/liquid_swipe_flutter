import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:liquid_swipe/Helpers/SlideUpdate.dart';
import 'package:liquid_swipe/PageHelpers/animated_page_dragger.dart';
import 'package:liquid_swipe/PageHelpers/page_dragger.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';

/// Internal Class
///
/// A [ChangeNotifierProvider] to manage [LiquidSwipe] State.
/// Every Change is notified from it.
/// Methods Included :
///  -  [animateToPage]
///  -  [_animateDirectlyToPage]
///  -  [jumpToPage]
///  -  [updateData]
///  -  some more, soon.
class LiquidProvider extends ChangeNotifier {
  /// A [SlideUpdate] type for storing the current Slide Update.
  SlideUpdate? slideUpdate;

  /// [AnimatedPageDragger] required for completing the animation when [UpdateType] is [UpdateType.doneAnimating]
  late AnimatedPageDragger animatedPageDragger;

  /// Storing ActivePage Index
  /// default = 0
  int activePageIndex = 0;

  ///Storing next Page Index
  ///default = 0
  int nextPageIndex = 0;

  ///Storing the Swipe Direction using [SlideDirection]
  SlideDirection slideDirection = SlideDirection.none;

  /// percentage of slide both Horizontal and Vertical, during touch
  double slidePercentHor = 0.00;
  double slidePercentVer = 0.00;

  ///Storing Previous [UpdateType]
  UpdateType? prevUpdate;

  ///user manageable bool to make Enable and Disable loop within the Pages
  bool enableLoop = true;

  ///Number of Page.
  int pagesLength = 0;

  ///Ticker Provider from [LiquidSwipe], cause need to use it in [AnimatedPageDragger]
  late TickerProviderStateMixin singleTickerProviderStateMixin;

  ///SlideIcon position, always Horizontal, used in [PageDragger]
  late double positionSlideIcon;

  ///see [CurrentUpdateTypeCallback]
  CurrentUpdateTypeCallback? _currentUpdateTypeCallback;

  ///see [OnPageChangeCallback]
  OnPageChangeCallback? _onPageChangeCallback;

  ///see [SlidePercentCallback]
  SlidePercentCallback? _slidePercentCallback;

  ///bool variable to set if Liquid Swipe is currently in Progress
  bool isInProgress = false;

  ///bool to store is its still animating
  bool _isAnimating = false;

  ///A user handled value if user want, just only to use programmatic pages changes
  ///default = false
  bool shouldDisableUserGesture = false;

  bool enableSideReveal = false;

  Size iconSize = Size.zero;

  Timer? _timer;
  Timer? _timerInner;

  ///Constructor
  ///Contains Default value or Developer desired Values
  /// [initialPage] - Initial Page of the LiquidSwipe (0 - n)
  /// [loop]  - Should Enable Loop between Pages
  /// [length]  - Total Number of Pages
  LiquidProvider({
    required int initialPage,
    required bool loop,
    required int length,
    required TickerProviderStateMixin vsync,
    required double slideIcon,
    required OnPageChangeCallback? onPageChangeCallback,
    required CurrentUpdateTypeCallback? currentUpdateTypeCallback,
    required SlidePercentCallback? slidePercentCallback,
    required bool disableGesture,
    required bool enableSideReveal,
  }) {
    slidePercentHor = 0.00;
    slidePercentVer = 0.00;
    activePageIndex = initialPage;
    nextPageIndex = initialPage;
    enableLoop = loop;
    pagesLength = length;
    singleTickerProviderStateMixin = vsync;
    positionSlideIcon = slideIcon;
    _currentUpdateTypeCallback = currentUpdateTypeCallback;
    _slidePercentCallback = slidePercentCallback;
    _onPageChangeCallback = onPageChangeCallback;
    shouldDisableUserGesture = disableGesture;
    this.enableSideReveal = enableSideReveal;

    updateSlide(SlideUpdate(
      SlideDirection.rightToLeft,
      0.00,
      positionSlideIcon,
      UpdateType.dragging,
    ));
  }

  ///Animating page to the mentioned page
  ///
  ///Known Issue : First we have to jump to the previous screen.
  ///
  ///Current Behaviour : Lets say there are 3 pages,
  ///current page is Red and next is Blue and and last is Green.
  ///if [page] in this method came to ne 2 i.e., we need to animate directly to Green Page
  ///but currently I have to jump to page 1 i.e., Blue and than perform Animation using [updateSlide]
  ///
  ///Required Behaviour : I Don't want Blue to be there in between the transition of Red and Green i.e.,
  ///If we are animating [activePageIndex] should be 0 and [nextPageIndex] should be 2, which is not possible through current implementation.
  ///
  /// If you encounter this and have suggestions don't forget to raise an Issue.
  ///
  ///Not making it for Public usage for now due to the mentioned Issue
  /// _animateDirectlyToPage(int page, int duration) {
  ///   if (isInProgress || activePageIndex == page) return;
  ///   isInProgress = true;
  ///   activePageIndex = page - 1;
  ///   nextPageIndex = page;
  ///   if (activePageIndex < 0) {
  ///     activePageIndex = 0;
  ///     jumpToPage(page);
  ///     return;
  ///   }
  ///   _timer = Timer.periodic(const Duration(milliseconds: 1), (t) {
  ///     if (t.tick < duration / 2) {
  ///       updateSlide(SlideUpdate(SlideDirection.rightToLeft, t.tick / duration,
  ///           1, UpdateType.dragging));
  ///     } else if (t.tick < duration) {
  ///       updateSlide(SlideUpdate(SlideDirection.rightToLeft, t.tick / duration,
  ///           1, UpdateType.animating));
  ///     } else {
  ///       updateSlide(SlideUpdate(
  ///           SlideDirection.rightToLeft, 1, 1, UpdateType.doneAnimating));
  ///       t.cancel();
  ///       isInProgress = false;
  ///     }
  ///   });
  /// }
  ///
  ///Animating to the Page in One-by-One manner
  ///Required parameters :
  /// - [page], the page index you want to animate to.
  /// - [duration], of [Duration] type, for complete animation
  animateToPage(int page, int duration) {
    if (isInProgress || activePageIndex == page) return;
    isInProgress = true;
    int diff = 0;
    _timer?.cancel();
    _timerInner?.cancel();
    if (activePageIndex < page) {
      diff = page - activePageIndex;
      int newDuration = duration ~/ diff;
      _timer = Timer.periodic(Duration(milliseconds: newDuration), (callback) {
        _timerInner = Timer.periodic(const Duration(milliseconds: 1), (t) {
          if (t.tick < newDuration / 2) {
            updateSlide(SlideUpdate(SlideDirection.rightToLeft,
                t.tick / newDuration, positionSlideIcon, UpdateType.dragging));
          } else if (t.tick < newDuration) {
            updateSlide(SlideUpdate(SlideDirection.rightToLeft,
                t.tick / newDuration, positionSlideIcon, UpdateType.animating));
          } else {
            updateSlide(SlideUpdate(SlideDirection.rightToLeft, 1,
                positionSlideIcon, UpdateType.doneAnimating));
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
      _timer = Timer.periodic(Duration(milliseconds: newDuration), (callback) {
        _timerInner = Timer.periodic(const Duration(milliseconds: 1), (t) {
          if (t.tick < newDuration / 2) {
            updateSlide(SlideUpdate(SlideDirection.leftToRight,
                t.tick / newDuration, positionSlideIcon, UpdateType.dragging));
          } else if (t.tick < newDuration) {
            updateSlide(SlideUpdate(SlideDirection.leftToRight,
                t.tick / newDuration, positionSlideIcon, UpdateType.animating));
          } else {
            updateSlide(SlideUpdate(SlideDirection.leftToRight, 1,
                positionSlideIcon, UpdateType.doneAnimating));
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

  ///Directly Jump to the mentioned [page] without any animation
  jumpToPage(int page) {
    if (page == activePageIndex || isInProgress) return;
    if (page > pagesLength - 1 || page < 0) {
      throw ("Index $page not found in the Pages list");
    }
    isInProgress = true;
    activePageIndex = page - 1;
    nextPageIndex = page;
    if (nextPageIndex >= pagesLength) nextPageIndex = 0;
    updateSlide(SlideUpdate(SlideDirection.rightToLeft, 1, positionSlideIcon,
        UpdateType.doneAnimating));
    isInProgress = false;
  }

  ///Method to update the [slideUpdate] and it directly calls [updateData]
  updateSlide(SlideUpdate slidUpdate) {
    slideUpdate = slidUpdate;
    updateData(slidUpdate);
    notifyListeners();
  }

  ///updating data using [SlideUpdate], generally we are handling and managing the Animation [UpdateType]
  ///in this methods,
  ///All callbacks and factors are also managed by this method.
  updateData(SlideUpdate event) {
    if (!enableLoop) if (event.direction == SlideDirection.leftToRight &&
        activePageIndex == 0) {
      return;
    } else if (event.direction == SlideDirection.rightToLeft &&
        activePageIndex == pagesLength - 1) {
      return;
    }

    if (prevUpdate != event.updateType && _currentUpdateTypeCallback != null)
      _currentUpdateTypeCallback!(event.updateType);

    if (_slidePercentCallback != null &&
        event.updateType != UpdateType.doneAnimating) {
      String hor = (event.slidePercentHor * 100).toStringAsExponential(2);
      String ver = (event.slidePercentVer * 100).toStringAsExponential(2);
      _slidePercentCallback!(
          double.parse(hor), (((double.parse(ver)) * 100) / 100));
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
    if (_onPageChangeCallback != null) {
      _onPageChangeCallback!(nextPageIndex);
    }
    activePageIndex = nextPageIndex;
    slideDirection = SlideDirection.rightToLeft;
    slidePercentHor = 0.00;
    slidePercentVer = positionSlideIcon;
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
    } else {
      if (slideDirection == SlideDirection.leftToRight &&
          activePageIndex != 0) {
        nextPageIndex = activePageIndex - 1;
      } else if (slideDirection == SlideDirection.rightToLeft &&
          activePageIndex != pagesLength - 1) {
        nextPageIndex = activePageIndex + 1;
      }
    }

    isAnimating = false; // Page stopped animating
    return;
  }

  ///Setter for [_isAnimating]
  set isAnimating(bool newValue) {
    this._isAnimating = newValue;
    notifyListeners();
  }

  ///Getter for [_isAnimating]
  bool get isAnimating => _isAnimating;

  ///Setter for [isUserGestureDisabled]
  set setUserGesture(bool disable) {
    this.shouldDisableUserGesture = disable;
    notifyListeners();
  }

  ///Setter for [isUserGestureDisabled]
  bool get isUserGestureDisabled => shouldDisableUserGesture;

  ///Method to set [iconSize]
  setIconSize(Size size) {
    iconSize = size;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timerInner?.cancel();
    super.dispose();
  }
}
