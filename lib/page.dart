import 'package:flutter/material.dart';

/// This is the class which contains the Page UI.
class Page extends StatelessWidget {
  ///page details
  final Container pageView;

  //Constructor
  Page({
    this.pageView,
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
