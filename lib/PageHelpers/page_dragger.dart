import 'package:flutter/material.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/Helpers/slide_update.dart';
import 'package:liquid_swipe/Provider/iamariderprovider.dart';
import 'package:provider/provider.dart';

/// This class is used to get user gesture and work according to it.

class PageDragger extends StatefulWidget {
  final double fullTransitionPX;
  final bool enableSlideIcon;
  final Widget slideIconWidget;
  final double iconPosition;

  //Constructor
  PageDragger({
    this.fullTransitionPX = FULL_TARNSITION_PX,
    this.enableSlideIcon = false,
    this.slideIconWidget,
    this.iconPosition,
  }) : assert(fullTransitionPX != null);

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  //Variables
  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercentHor = 0.0;
  double slidePercentVer = 0.0;

  // This methods executes when user starts dragging.
  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  // This methods executes while user is dragging.
  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      //Getting new position details
      final newPosition = details.globalPosition;
      //Change in position in x
      final dx = dragStart.dx - newPosition.dx;
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
        slidePercentVer = (dy / 500).abs().clamp(0.0, 1.25);
      }

      // Adding to slideUpdateStream
      Provider.of<IAmARiderProvider>(context, listen: false)
          .updateSlide(SlideUpdate(
        slideDirection,
        slidePercentHor,
        slidePercentVer,
        UpdateType.dragging,
      ));
    }
  }

  // This method executes when user ends dragging.
  onDragEnd(DragEndDetails details) {
    // Adding to slideUpdateStream
    Provider.of<IAmARiderProvider>(context, listen: false)
        .updateSlide(SlideUpdate(
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
  Widget build(BuildContext context) {
    //Gesture Detector for horizontal drag
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      onVerticalDragStart: onDragStart,
      onVerticalDragEnd: onDragEnd,
      onVerticalDragUpdate: onDragUpdate,
      child: widget.enableSlideIcon
          ? Align(
              alignment: Alignment(
                1 - slidePercentHor + 0.005,
                widget.iconPosition + widget.iconPosition / 10,
              ),
              child: Opacity(
                opacity: 1 - slidePercentHor,
                child: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  child: slideDirection != SlideDirection.leftToRight
                      ? widget.slideIconWidget
                      : null,
                  foregroundColor: Colors.black,
                ),
              ),
            )
          : null,
    );
  }
}
