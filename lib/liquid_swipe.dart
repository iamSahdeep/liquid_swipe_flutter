import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_swipe/Animation_Gesture/animated_page_dragger.dart';
import 'package:liquid_swipe/Animation_Gesture/page_dragger.dart';
import 'package:liquid_swipe/Constants/constants.dart';
import 'package:liquid_swipe/page.dart';

import 'Animation_Gesture/page_reveal.dart';

final key = new GlobalKey<_LiquidSwipe>();
class LiquidSwipe extends StatefulWidget {
  final List<Container> pages;
  final double fullTransitionValue;
  final int initialPage;
  final bool enableSlideIcon;

  const LiquidSwipe({
    Key key,
    @required this.pages,
    this.fullTransitionValue = FULL_TARNSITION_PX,
    this.initialPage = 0,
    this.enableSlideIcon = false,
  })
      : assert(pages != null),
        assert(fullTransitionValue != null),
        assert(initialPage != null && initialPage >= 0 &&
            initialPage < pages.length),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LiquidSwipe();
}

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercent;

  SlideUpdate(this.direction,
      this.slidePercent,
      this.updateType,);
}

class _LiquidSwipe extends State<LiquidSwipe> with TickerProviderStateMixin {


  StreamController<SlideUpdate>
  // ignore: close_sinks
  slideUpdateStream; //Stream controller is used to get all the updates when user slides across screen.

  AnimatedPageDragger
  animatedPageDragger; //When user stops dragging then by using this page automatically drags.

  int activePageIndex = 0; //active page index
  int nextPageIndex = 0; //next page index
  SlideDirection slideDirection = SlideDirection.none; //slide direction
  double slidePercent = 0.0; //slide percentage (0.0 to 1.0)
  StreamSubscription<SlideUpdate> slideUpdateStream$;

  @override
  void initState() {
    activePageIndex = widget.initialPage;
    nextPageIndex = widget.initialPage;
    //Stream Controller initialization
    slideUpdateStream = StreamController<SlideUpdate>();
    //listening to updates of stream controller
    slideUpdateStream$ = slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        //setState is used to change the values dynamically

        //if the user is dragging then
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          //conditions on slide direction
          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activePageIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activePageIndex + 1;
          } else {
            nextPageIndex = activePageIndex;
          }
          // making pages to be in loop
          if (nextPageIndex > widget.pages.length - 1)
            nextPageIndex = 0;
          else if (nextPageIndex < 0) nextPageIndex = widget.pages.length - 1;
        }
        //if the user has done dragging
        else if (event.updateType == UpdateType.doneDragging) {
          // slidepercent > 0.2 so that it wont reveal itself unless this condition is true
          if (slidePercent > 0.2) {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );

            nextPageIndex = activePageIndex;
            //to continue in the loop of pages
            if (nextPageIndex > widget.pages.length - 1)
              nextPageIndex = 0;
            else if (nextPageIndex < 0) nextPageIndex = widget.pages.length - 1;
          }
          //Run the animation
          animatedPageDragger.run();
        }
        //when animating
        else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        }
        //done animating
        else if (event.updateType == UpdateType.doneAnimating) {
          activePageIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.5;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    slideUpdateStream$?.cancel();
    animatedPageDragger?.dispose();
    slideUpdateStream?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Container> pages = widget.pages;
    return Scaffold(
      //Stack is used to place components over one another.
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Page(
            pageView: slideDirection == SlideDirection.leftToRight
                ? pages[activePageIndex]
                : pages[nextPageIndex],
            percentVisible: 1.0,
          ),
          //Pages
          PageReveal(
            //next page reveal
            revealPercent: slidePercent,
            child: Page(
                pageView: slideDirection == SlideDirection.leftToRight
                    ? pages[nextPageIndex]
                    : pages[activePageIndex],
                percentVisible: slidePercent),
            slideDirection: slideDirection,
          ),
          PageDragger(
            //Used for gesture control
            fullTransitionPX: widget.fullTransitionValue,
            slideUpdateStream: this.slideUpdateStream,
            enableSlideIcon: widget.enableSlideIcon,
          ), //PageDragger
        ], //Widget
      ), //Stack
    ); //Scaffold
  }

  next() {
    _LiquidSwipe().setState(() {
      activePageIndex += 1;
      nextPageIndex = activePageIndex + 1;
    });
  }
}
