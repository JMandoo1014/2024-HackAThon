import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnflutter/main.dart';

void main() {
  testWidgets('Add and display a new to-do item', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the to-do tab
    await tester.tap(find.text('To-Do'));
    await tester.pumpAndSettle();

    // Enter text and add a to-do item
    await tester.enterText(find.byType(TextField), 'New Task');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the new to-do item is displayed
    expect(find.text('New Task'), findsOneWidget);
  });

  testWidgets('Select a date and display events', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the calendar tab
    await tester.tap(find.text('Calendar'));
    await tester.pumpAndSettle();

    // Select a date
    await tester.tap(find.text('15'));
    await tester.pump();

    // Verify no events for this date
    expect(find.text('No events for this day'), findsNothing);

    // Add an event to the selected date
    await tester.enterText(find.byType(TextField), 'Meeting');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the new event is displayed
    expect(find.text('Meeting'), findsOneWidget);
  });
}
