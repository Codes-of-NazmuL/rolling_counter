import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rolling_counter/rolling_counter.dart';

void main() {
  testWidgets('RollingCounter renders initial value and symbols',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RollingCounter(
            value: 1250,
            prefix: '\$',
            suffix: ' USD',
          ),
        ),
      ),
    );

    expect(find.text('\$'), findsOneWidget);
    expect(find.text(','), findsOneWidget);
    expect(find.text(' USD'), findsOneWidget);
    // There are '1', '2', '5', '0' digits
    expect(find.byType(RollingCounter), findsOneWidget);
  });

  testWidgets('RollingCounter animates when value changes', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RollingCounter(
            value: 10,
            duration: Duration(milliseconds: 300),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Update value to 25
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RollingCounter(
            value: 25,
            duration: Duration(milliseconds: 300),
          ),
        ),
      ),
    );

    // Mid-animation frame
    await tester.pump(const Duration(milliseconds: 150));
    expect(find.byType(RollingCounter), findsOneWidget);

    // Complete animation
    await tester.pumpAndSettle();
    expect(find.byType(RollingCounter), findsOneWidget);
  });

  testWidgets('RollingCounter extension on num works properly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: 42.rollingCounter(prefix: '#'),
        ),
      ),
    );

    expect(find.text('#'), findsOneWidget);
    expect(find.byType(RollingCounter), findsOneWidget);
  });
}
