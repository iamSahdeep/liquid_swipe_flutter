import 'package:flutter/material.dart';
import 'package:liquid_swipe/Provider/LiquidProvider.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';

/// Added in v1.5.0
///
/// A controller class similar to [PageController] but with Limited Capabilities for now.
/// Provides method for dynamic changes to the [LiquidSwipe]
///
/// Simple Usage :
///
/// Firstly make an Object of [LiquidController] and initialize it in `initState()`
///
/// ```dart
///    LiquidController liquidController;
///
///    @override
///    void initState() {
///    super.initState();
///    liquidController = LiquidController();
///    }
/// ```
///
/// Now simply add it to [LiquidSwipe]'s Constructor
///
/// ```dart
///    LiquidSwipe(
///         pages: pages,
///         LiquidController: liquidController,
///     ),
///
/// ```
///
/// Only Rules/Limitation to its Usage is For now you can't use any method in Liquid Controller before build method is being called in which [LiquidSwipe] is initialized
///
/// So we have to use them after LiquidSwipe is Built
///
///
class LiquidController {
  ///Provider model calls (not listenable) just used for calling its internal methods
  LiquidProvider? _provider;

  LiquidController();

  ///Internal Method Should not be used.
  setContext(BuildContext context) {
    _provider = Provider.of<LiquidProvider>(context, listen: false);
  }

  ///Jump Directly to mentioned Page index but without Animation
  ///see also : [LiquidProvider.jumpToPage]
  jumpToPage({required int page}) {
    assert(_provider != null,
        "LiquidController not attached to any LiquidSwipe Widget.");
    _provider?.jumpToPage(page);
  }

  ///Animate to mentioned page within given [Duration]
  ///Remember the [duration] here is the total duration in which it will animate though all pages not the single page
  animateToPage({required int page, int duration = 600}) {
    assert(_provider != null,
        "LiquidController not attached to any LiquidSwipe Widget.");
    _provider?.animateToPage(page, duration);
  }

  ///Getter to get current Page
  ///see also : [OnPageChangeCallback]
  int get currentPage => _provider?.activePageIndex ?? 0;

  ///Use this method to disable gestures during runtime, like on certain pages using [OnPageChangeCallback]
  ///If you want to disable gestures from start use [LiquidSwipe.disableUserGesture]
  shouldDisableGestures({required bool disable}) {
    assert(_provider != null,
        "LiquidController not attached to any LiquidSwipe Widget.");
    _provider?.setUserGesture = disable;
  }

  ///If somehow you want to check if gestures are disabled or not
  ///Returns [bool]
  bool get isUserGestureDisabled => _provider?.isUserGestureDisabled ?? false;
}
