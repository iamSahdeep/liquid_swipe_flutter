import 'package:flutter/material.dart';

/// This is the class which contains the Page UI.
class Page extends StatelessWidget {
  ///page details
  final Container pageView;

  ///percent visible of page
  final double percentVisible;

  //Constructor
  Page({
    this.pageView,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        this.pageView,
      ],
    );
  }
}
