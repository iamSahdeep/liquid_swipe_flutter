import 'package:liquid_swipe/Helpers/Helpers.dart';

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercentHor;
  final double slidePercentVer;

  SlideUpdate(
    this.direction,
    this.slidePercentHor,
    this.slidePercentVer,
    this.updateType,
  );
}
