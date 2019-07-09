# liquid_swipe [![Pub](https://img.shields.io/pub/v/liquid_swipe.svg?style=flat-square)](https://pub.dartlang.org/packages/liquid_swipe)


Liquid swipe is the revealing clipper to stacked Container and inspired by [Cuberto's liquid swipe](https://github.com/Cuberto/liquid-swipe) and [IntroViews](https://github.com/aagarwal1012/IntroViews-Flutter).

### Sample 

![Video](https://github.com/iamSahdeep/liquid_swipe_flutter/blob/master/example.gif)

### APK
 [Download](https://github.com/iamSahdeep/liquid_swipe_flutter/blob/master/app-release.apk)

## Usage
* Add this to your pubspec.yaml
  ```
  dependencies:
  liquid_swipe: ^1.0.1
  
  ```
* Get package from Pub:

  ```
  flutter packages get
  ```
* Import it in your file

  ```
  import 'package:liquid_swipe/liquid_swipe.dart';
  ```
## Example

 * First, create a list of Containers.
 ```
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
  ];
 ```
 
 * Second, just pass it to liquidswipe constructor.
 ```
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Builder(
          builder: (context) =>
              LiquidSwipe(
                  pages: pages
              )),
    );
  }
 ```
 * Remember pages can only be containers.
 * Check out the complete [Example](https://github.com/iamSahdeep/liquid_swipe_flutter/tree/master/example)
 
### Credits
   - [Cuberto](https://github.com/Cuberto) for awesome [Liquid Swipe](https://github.com/Cuberto/liquid-swipe) in Swift.
   - [@aagarwal1012](https://github.com/aagarwal1012) for [IntroViews](https://github.com/aagarwal1012/IntroViews-Flutter), It made my work too less.
 
 
## Author & support
This project is created by [Sahdeep Singh](https://github.com/iamSahdeep) but with lots of support and help. See the [Credits](https://github.com/iamSahdeep/Bop/blob/master/README.md#credits).

<img src="https://cdn-images-1.medium.com/max/1200/1*2yFbiGdcACiuLGo4dMKmJw.jpeg" width="60" height="30">

