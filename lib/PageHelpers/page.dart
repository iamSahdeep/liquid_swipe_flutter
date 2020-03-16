import 'package:flutter/material.dart';

/// This is the class which contains the Page UI.
class Page extends StatelessWidget {
  ///page details
  final Widget pageView;

  //Constructor
  Page({
    this.pageView,
  });

  @override
  Widget build(BuildContext context) {
    return this.pageView;
  }
}
