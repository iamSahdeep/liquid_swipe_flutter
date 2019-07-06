import 'package:flutter/material.dart';
import 'package:liquid_swipe/WaveLayer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: new CustomPaint(
            painter: new WaveLayer(waveCenterY: 0, waveHorRadius: 20, waveVertRadius: 400, sideWidth: 100),
          )
        ),
      ),
    );
  }
}
