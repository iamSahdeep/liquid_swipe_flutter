import 'package:flutter/material.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/Helpers/SlideUpdate.dart';
import 'package:liquid_swipe/Provider/LiquidProvider.dart';
import 'package:provider/provider.dart';

/// Internal Widget
///
/// PageDragger is a Widget that handles user gestures and provide the data to the [LiquidProvider]
/// from where we perform animations various other methods.
class PageDragger extends StatefulWidget {
  /// Used to make animation faster or slower through it corresponding value
  /// default : [FULL_TRANSITION_PX]
  final double fullTransitionPX;

  /// Slide Icon whichever provided
  final Widget? slideIconWidget;

  /// double value should range from 0.0 - 1.0
  final double? iconPosition;

  /// boolean parameter to make user gesture disabled which LiquidSwipe is still Animating
  final bool ignoreUserGestureWhileAnimating;

  ///Constructor with some default values
  PageDragger({
    this.fullTransitionPX = FULL_TRANSITION_PX,
    this.slideIconWidget,
    this.iconPosition,
    this.ignoreUserGestureWhileAnimating = false,
  });

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

///State for PageDragger
class _PageDraggerState extends State<PageDragger> {
  GlobalKey _keyIcon = GlobalKey();

  ///Current [Offset] of the User Touch
  Offset? dragStart;

  ///Calculated Slide Direction of the Gesture/Swipe
  SlideDirection slideDirection = SlideDirection.none;

  ///Horizontally calculated slide percentage, ranges from 0.0 - 1.0
  double slidePercentHor = 0.0;

  ///Same as [slidePercentHor] but for Vertical Swipe and ranges from 0.0 - 1.25
  double slidePercentVer = 0.0;

  /// Method invoked when ever user touch the screen and drag starts
  /// called at [GestureDetector.onHorizontalDragStart]
  onDragStart(DragStartDetails details) {
    final model = Provider.of<LiquidProvider>(context, listen: false);

    ///Ignoring user gesture if the animation is running (optional)
    if (model.isAnimating && widget.ignoreUserGestureWhileAnimating ||
        model.isUserGestureDisabled) {
      return;
    }
    dragStart = details.globalPosition;
  }

  ///Updating data while user drags and touch offset changes
  ///called at [GestureDetector.onHorizontalDragUpdate]
  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      //Getting new position details
      final newPosition = details.globalPosition;
      //Change in position in x
      final dx = dragStart!.dx - newPosition.dx;
      final dy = newPosition.dy;

      slideDirection = SlideDirection.none;
      //predicting slide direction
      if (dx > 0.0) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0) {
        slideDirection = SlideDirection.leftToRight;
      }

      //predicting slide percent
      if (slideDirection != SlideDirection.none) {
        //clamp method is used to clamp the value of slidePercent from 0.0 to 1.0, after 1.0 it set to 1.0
        slidePercentHor = (dx / widget.fullTransitionPX).abs().clamp(0.0, 1.0);
        slidePercentVer =
            (dy / MediaQuery.of(context).size.height).abs().clamp(0.0, 1.0);
      }

      Provider.of<LiquidProvider>(context, listen: false)
          .updateSlide(SlideUpdate(
        slideDirection,
        slidePercentHor,
        slidePercentVer,
        UpdateType.dragging,
      ));
    }
  }

  ///This method executes when user ends dragging and leaves the screen
  ///called at [GestureDetector.onHorizontalDragEnd]
  onDragEnd(DragEndDetails details) {
    Provider.of<LiquidProvider>(context, listen: false).updateSlide(SlideUpdate(
      SlideDirection.none,
      slidePercentHor,
      slidePercentVer,
      UpdateType.doneDragging,
    ));

    //Making dragStart to null for the reallocation
    slidePercentHor = slidePercentVer = 0;
    slideDirection = SlideDirection.none;
    dragStart = null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.slideIconWidget != null)
        Provider.of<LiquidProvider>(context, listen: false)
            .setIconSize(_keyIcon.currentContext!.size!);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Gesture Detector for horizontal drag
    final model = Provider.of<LiquidProvider>(context, listen: false);

    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: model.isInProgress ? null : onDragStart,
        onHorizontalDragUpdate: model.isInProgress ? null : onDragUpdate,
        onHorizontalDragEnd: model.isInProgress ? null : onDragEnd,
        child: Align(
          alignment: Alignment(
            1 - slidePercentHor,
            -1.0 + Utils.handleIconAlignment(widget.iconPosition!) * 2,
          ),
          child: Opacity(
            opacity: 1 - slidePercentHor,
            child: slideDirection != SlideDirection.leftToRight &&
                    widget.slideIconWidget != null
                ? SizedBox(
                    key: _keyIcon,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 10.0),
                      child: widget.slideIconWidget,
                    ),
                  )
                : null,
          ),
        ));
  }
}
