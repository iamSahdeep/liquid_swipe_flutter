import 'package:flutter/material.dart';
import 'package:liquid_swipe/Provider/iamariderprovider.dart';
import 'package:provider/provider.dart';

class LiquidController {
  BuildContext context;

  LiquidController();

  setContext(BuildContext c) {
    context = c;
  }

  jumpToPage({int page}) {
    Provider.of<IAmARiderProvider>(context, listen: false).jumpToPage(page);
  }

  animateToPage({int page, int duration}) {
    Provider.of<IAmARiderProvider>(context, listen: false).animateToPage(
        page, duration);
  }
}
