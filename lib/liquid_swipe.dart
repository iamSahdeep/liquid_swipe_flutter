import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class LiquidSwipe extends StatefulWidget {
  final Stack stack;

  LiquidSwipe({
    @required this.stack,
});

  @override
  State<StatefulWidget> createState() => _LiquidSwipe(
    this.stack,
  );

}

class _LiquidSwipe extends State<LiquidSwipe> {
  Stack _stack;
  int currentIndex;
  _LiquidSwipe(Stack s){
   _stack = s;
   currentIndex = 0;
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return null;
  }
}