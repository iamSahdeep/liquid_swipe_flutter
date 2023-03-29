import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

final textTest1 = "Testing String One";
final liquidController = LiquidController();
final liquidSwipeWidgetLR = LiquidSwipe(
  liquidController: liquidController,
  slideIconWidget: Icon(Icons.arrow_back_ios),
  enableLoop: false,
  waveType: WaveType.liquidReveal,
  pages: [
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.deepOrange,
      child: Center(child: Text(textTest1, textDirection: TextDirection.ltr),),
    ),
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.red,
    )
  ],
);
final liquidSwipeWidgetLR2 = LiquidSwipe(
  liquidController: liquidController,
  slideIconWidget: Icon(Icons.arrow_back_ios),
  pages: [
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.deepOrange,
    ),
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.red,
    )
  ],
);

final liquidSwipeWidgetCR = LiquidSwipe(
  slideIconWidget: Icon(Icons.arrow_back_ios),
  liquidController: liquidController,
  waveType: WaveType.circularReveal,
  positionSlideIcon: 0.2,
  onPageChangeCallback: (_){},
  slidePercentCallback: (_, __){},
  currentUpdateTypeCallback: (_){},
  pages: [
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.deepOrange,
    ),
    Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.red,
    )
  ],
);

void main() {
  testWidgets('Liquid Swipe main widget test : ', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp( home : Scaffold(body:liquidSwipeWidgetLR)));

    final findLiquidSwipeLR = find.byWidget(liquidSwipeWidgetLR);
    expect(findLiquidSwipeLR, findsOneWidget);

    final findTextInLS = find.text(textTest1);
    expect(findTextInLS, findsOneWidget);

    expect(liquidController.currentPage, 0);
    liquidController.jumpToPage(page: 1);
    expect(liquidController.currentPage, 1);

    await tester.runAsync(() async{
      liquidController.animateToPage(page: 0);
      expect(liquidController.currentPage, 1);
    });

    liquidController.shouldDisableGestures(disable: true);
    expect(liquidController.isUserGestureDisabled, true);

    liquidController.jumpToPage(page: 0);

    await tester.drag(find.byType(MaterialApp), Offset(-400.0, 0.0));

    await tester.pumpAndSettle();

    expect(liquidController.currentPage, 1);

  });

  testWidgets("For Circular Reveal", (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp( home : Scaffold(body:liquidSwipeWidgetCR)));
    final findLiquidSwipeCR = find.byWidget(liquidSwipeWidgetCR);
    expect(findLiquidSwipeCR, findsOneWidget);

    await tester.drag(find.byType(MaterialApp), Offset(400.0, 0.0));

    await tester.pumpAndSettle();

    expect(liquidController.currentPage, 1);

    liquidController.animateToPage(page: 4);
    expect(liquidController.currentPage, 1);

  });

  testWidgets("For Liquid Swipe but rtl", (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp( home : Scaffold(body:liquidSwipeWidgetLR2)));

    liquidController.jumpToPage(page: 0);

    await tester.drag(find.byType(MaterialApp), Offset(400.0, 100.0));

    await tester.pumpAndSettle();

    expect(liquidController.currentPage, 1);

    liquidController.jumpToPage(page: 0);

    await tester.drag(find.byType(MaterialApp), Offset(-400.0, 100.0));

    await tester.pumpAndSettle();

    expect(liquidController.currentPage, 1);

  });
}
