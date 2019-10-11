import 'package:flutter/material.dart';
import 'package:liquid_swipe/Constants/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'secondExample.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
void main() {
  runApp(
    new MyApp(),
  );
}

class MyApp extends StatelessWidget {

  final pages = [
    Container(
      color: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Hi",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "It's Me",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Sahdeep",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Take a",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "look at",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Liquid Swipe",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      color: Colors.greenAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Liked?",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Fork!",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Give Star!",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      color: Colors.yellowAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Can be",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Used for",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Onboarding Design",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Do",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Try it",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Thank You",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(padding: const EdgeInsets.all(20.0)),
          Column(
            children: <Widget>[
              new Text(
                "Lets ",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "Try Another Example",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billy",
                    fontWeight: FontWeight.w600),
              ),
              FlatButton(
                disabledColor: Colors.deepPurpleAccent,
                onPressed: () {
                  Navigator.push(
                    navigatorKey.currentContext,
                    MaterialPageRoute(builder: (context) => SecondExample()),
                  );
                },
                child: Text(
                  "Click Here",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Billy",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  ];
  int page = 0;
  UpdateType updateType;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        navigatorKey: navigatorKey,
        home: new Scaffold(
            body: LiquidSwipe(
              pages: pages,
              fullTransitionValue: 200,
              enableSlideIcon: true,
              enableLoop: false,
              positionSlideIcon: 0.5,
              waveType: WaveType.liquidReveal,
              onPageChangeCallback: (page) => pageChangeCallback(page),
              currentUpdateTypeCallback: (updateType) => updateTypeCallback(updateType),
            )));
  }

  pageChangeCallback(int page) {
    print(page);
  }
  updateTypeCallback(UpdateType updateType) {
    print(updateType);
  }
}
