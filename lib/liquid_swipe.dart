import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:liquid_swipe/PageHelpers/page.dart';
import 'package:liquid_swipe/PageHelpers/page_dragger.dart';
import 'package:liquid_swipe/PageHelpers/page_reveal.dart';
import 'package:liquid_swipe/Provider/iamariderprovider.dart';
import 'package:provider/provider.dart';

export 'package:liquid_swipe/Helpers/Helpers.dart';
export 'package:liquid_swipe/PageHelpers/LiquidController.dart';

final key = new GlobalKey<_LiquidSwipe>();

typedef OnPageChangeCallback = void Function(int activePageIndex);
typedef CurrentUpdateTypeCallback = void Function(UpdateType updateType);
typedef SlidePercentCallback = void Function(
    double slidePercentHorizontal, double slidePercetnVertical);

class LiquidSwipe extends StatefulWidget {
  final List<Widget> pages;
  final double fullTransitionValue;
  final int initialPage;
  final bool enableSlideIcon;
  final Widget slideIconWidget;
  final double positionSlideIcon;
  final bool enableLoop;
  final LiquidController liquidController;
  final WaveType waveType;
  final OnPageChangeCallback onPageChangeCallback;
  final CurrentUpdateTypeCallback currentUpdateTypeCallback;
  final SlidePercentCallback slidePercentCallback;

  final bool ignoreUserGestureWhileAnimating;
  final bool disableUserGesture;

  const LiquidSwipe({
    Key key,
    @required this.pages,
    this.fullTransitionValue = FULL_TARNSITION_PX,
    this.initialPage = 0,
    this.enableSlideIcon = false,
    this.slideIconWidget = const Icon(Icons.arrow_back_ios),
    this.positionSlideIcon = 0.54,
    this.enableLoop = true,
    this.liquidController,
    this.waveType = WaveType.liquidReveal,
    this.onPageChangeCallback,
    this.currentUpdateTypeCallback,
    this.slidePercentCallback,
    this.ignoreUserGestureWhileAnimating = false,
    this.disableUserGesture = false,
  })  : assert(pages != null),
        assert(fullTransitionValue != null),
        assert(initialPage != null &&
            initialPage >= 0 &&
            initialPage < pages.length),
        assert(positionSlideIcon >= -1 && positionSlideIcon <= 1),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LiquidSwipe();
}

class _LiquidSwipe extends State<LiquidSwipe> with TickerProviderStateMixin {
  LiquidController liquidController;

  @override
  void initState() {
    liquidController = widget.liquidController ?? LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = widget.pages;
    return ChangeNotifierProvider<IAmARiderProvider>(
      create: (BuildContext context) {
        return IAmARiderProvider(
            widget.initialPage,
            widget.enableLoop,
            pages.length,
            this,
            widget.positionSlideIcon,
            widget.onPageChangeCallback,
            widget.currentUpdateTypeCallback,
            widget.slidePercentCallback,
            widget.disableUserGesture);
      },
      child:
          Consumer(builder: (BuildContext context, IAmARiderProvider model, _) {
        liquidController.setContext(context);
        return Stack(
          children: <Widget>[
            CustomPage(
              pageView: model.slideDirection == SlideDirection.leftToRight
                  ? pages[model.activePageIndex]
                  : pages[model.nextPageIndex],
            ),
            //Pages
            PageReveal(
              //next page reveal
              revealPercent: model.slidePercentHor,
              child: CustomPage(
                pageView: model.slideDirection == SlideDirection.leftToRight
                    ? pages[model.nextPageIndex]
                    : pages[model.activePageIndex],
              ),
              slideDirection: model.slideDirection,
              iconPosition: widget.positionSlideIcon,
              waveType: widget.waveType,
              vertReveal: model.slidePercentVer,
            ),
            PageDragger(
              //Used for gesture control
              fullTransitionPX: widget.fullTransitionValue,
              enableSlideIcon: widget.enableSlideIcon,
              slideIconWidget: widget.slideIconWidget,
              iconPosition: widget.positionSlideIcon,
              ignoreUserGestureWhileAnimating:
                  widget.ignoreUserGestureWhileAnimating,
            ), //PageDragger
          ], //Widget//Stack
        );
      }),
    ); //Scaffold
  }
}
