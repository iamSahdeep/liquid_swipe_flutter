import 'package:flutter/material.dart';
import 'package:liquid_swipe/Provider/iamariderprovider.dart';
import 'package:provider/provider.dart';

class LiquidController {
  IAmARiderProvider provider;

  LiquidController();

  setContext(BuildContext context) {
    provider = Provider.of<IAmARiderProvider>(context, listen: false);
  }

  jumpToPage({int page}) {
    provider.jumpToPage(page);
  }

  animateToPage({int page, int duration = 600}) {
    provider.animateToPage(page, duration);
  }

  int get currentPage => provider.activePageIndex;

  shouldDisableGestures({bool disable}) {
    provider.setUserGesture = disable;
  }

  bool get isUserGestureDisabled => provider.isUserGestureDisabled;
}
