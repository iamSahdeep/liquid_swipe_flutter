import 'package:flutter/material.dart';

/// Abstract class to implement mentioned methods
/// [getChildAtIndex]
/// [itemCount]
abstract class LiquidSwipeChildDelegate {
  Widget getChildAtIndex(BuildContext context, int index);

  int itemCount();
}

/// Extends [LiquidSwipeChildDelegate] to implement methods for List of Pages
class LiquidSwipePagesChildDelegate extends LiquidSwipeChildDelegate {
  final List<Widget> pages;

  LiquidSwipePagesChildDelegate(this.pages);

  @override
  Widget getChildAtIndex(BuildContext context, int index) {
    if (index < 0 || index > pages.length - 1) {
      return ErrorWidget("index not in limit, index = $index");
    }
    return pages[index];
  }

  @override
  int itemCount() {
    return pages.length;
  }
}

/// Extends [LiquidSwipeChildDelegate] to implement methods for itemBuilder in [LiquidSwipe.builder(itemBuilder: itemBuilder, itemCount: itemCount)]
class LiquidSwipeBuilderChildDelegate extends LiquidSwipeChildDelegate {
  final IndexedWidgetBuilder itemBuilder;

  final int itemCountQ;

  LiquidSwipeBuilderChildDelegate(this.itemBuilder, this.itemCountQ);

  @override
  Widget getChildAtIndex(BuildContext context, int index) {
    return itemBuilder(context, index);
  }

  @override
  int itemCount() {
    return itemCountQ;
  }
}
