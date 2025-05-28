import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slicey_navbar/slicey_navbar.dart';

void main() {
  testWidgets('CarouselNavBar can be created with minimum requirements',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              bottomNavigationBar: CarouselNavBar(
                items: [
                  CarouselNavItem(icon: Icon(Icons.home)),
                  CarouselNavItem(icon: Icon(Icons.search)),
                ],
              ),
            ),
          ),
        );

        // Verify navigation bar is created properly
        expect(find.byType(CarouselNavBar), findsOneWidget);
        expect(find.byType(Icon), findsNWidgets(2));
      });
}