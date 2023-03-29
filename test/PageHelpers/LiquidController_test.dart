import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_swipe/Clippers/CircularWave.dart';

final clipPathWidget = CircularWave(iconSize, 0.0, 0.0);

final iconSize = Size(50, 50);

void main() {
  testWidgets('Circular Test : ', (WidgetTester tester) async {
    await tester.pumpWidget(ClipPath(
      clipper: clipPathWidget,
    ));
    final findClipPath = find.byType(ClipPath);
    expect(findClipPath, findsOneWidget);
  });

  group("CircularWave Method Tests", () {
    test('revealPercent', () {
      expect(clipPathWidget.revealPercent, equals(0.0));
    });
    test('verReveal', () {
      expect(clipPathWidget.verReveal, equals(0.0));
    });
    test('getPAth', () {
      expect(clipPathWidget.getClip(iconSize).runtimeType, Path);
    });
    test('shouldReclip', () {
      expect(clipPathWidget.shouldReclip(clipPathWidget), true);
    });
  });
}
