import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_swipe/Animation_Gesture/animated_page_dragger.dart';
import 'package:liquid_swipe/Animation_Gesture/page_dragger.dart';
import 'package:liquid_swipe/Constants/constants.dart';
import 'package:liquid_swipe/page.dart';

import 'Animation_Gesture/page_reveal.dart';

class LiquidSwipe extends StatefulWidget {
  final List<Container> pages;
  final double fullTransition;
  final int initPage;

  const LiquidSwipe({
    Key key,
    @required this.pages,
    this.fullTransition = FULL_TARNSITION_PX,
    this.initPage = 0,
  })
      : assert(pages != null),
        assert(fullTransition != null),
        assert(initPage != null && initPage >= 0 && initPage < pages.length),
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
    activePageIndex = widget.initPage;
    nextPageIndex = widget.initPage;
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
          slidePercent = 0.0;
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
            fullTransitionPX: widget.fullTransition,
            slideUpdateStream: this.slideUpdateStream,
          ), //PageDragger
        ], //Widget
      ), //Stack
    ); //Scaffold
  }
}
