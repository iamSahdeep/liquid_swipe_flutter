import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_swipe/Clippers/WaveLayer.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';

final clipPathWidget = WaveLayer(
    revealPercent: 0.0,
    slideDirection: SlideDirection.leftToRight,
    iconSize: iconSize,
    verReveal: 0.0,
    enableSideReveal: true);

final clipPathWidget2 = WaveLayer(
    revealPercent: 1,
    slideDirection: SlideDirection.rightToLeft,
    iconSize: iconSize,
    verReveal: 1,
    enableSideReveal: true);

final iconSize = Size(50, 50);

void main() {
  testWidgets('Wave Layer Test : ', (WidgetTester tester) async {
    await tester.pumpWidget(ClipPath(
      clipper: clipPathWidget,
    ));
    final findClipPath = find.byType(ClipPath);
    expect(findClipPath, findsOneWidget);

    await tester.pumpWidget(ClipPath(
      clipper: clipPathWidget2,
    ));
    final findClipPath2 = find.byType(ClipPath);
    expect(findClipPath2, findsOneWidget);
  });

  group("WaveLayer Method Tests", () {
    test('revealPercent', () {
      expect(clipPathWidget.revealPercent, 0.0);
    });
    test('verReveal', () {
      expect(clipPathWidget.verReveal, 0.0);
    });
    test('waveHorRadiusFBack', () {
      expect(clipPathWidget.waveHorRadiusFBack(Size.zero), iconSize.width);
    });

    test('waveHorRadiusFBack', () {
      expect(clipPathWidget.waveHorRadiusFBack(Size.zero), iconSize.width);
    });

    test('Path Check for exception', () {
      expect(clipPathWidget2.getClip(iconSize).runtimeType, Path);
    });

    test('waveHorRadiusF', () {
      expect(clipPathWidget.waveHorRadiusF(Size.zero), iconSize.width);
    });
    test('waveVertRadiusF', () {
      expect(clipPathWidget.waveVertRadiusF(Size.zero), iconSize.width);
    });
    test('sidewidth', () {
      expect(clipPathWidget.sidewidth(Size.zero), 15);
    });
  });
}
