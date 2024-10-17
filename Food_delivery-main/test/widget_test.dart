import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foddie_app/componets/add_to_cart.dart';
import 'package:foddie_app/main.dart';

void main() {
  testWidgets('Quantity increments and decrements properly',
      (WidgetTester tester) async {
    // Build the AddToCart widget
    await tester.pumpWidget(const MaterialApp(home: AddToCart()));

    // Verify the initial quantity starts at 1
    expect(find.text('1'), findsOneWidget);

    // Tap the '+' icon and trigger a frame
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the quantity is incremented to 2
    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsOneWidget);

    // Tap the '-' icon and trigger a frame
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    // Verify the quantity is decremented back to 1
    expect(find.text('2'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    // Try to decrement below 1
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    // Verify that the quantity does not go below 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
