import 'package:flutter_test/flutter_test.dart';
import 'package:cricket_target_challenge/main.dart';

void main() {
  testWidgets(
    'Pitch Challenge loads correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const PitchChallengeApp(),
      );

      expect(
        find.text('Pitch Challenge'),
        findsOneWidget,
      );

      expect(
        find.text('Runs'),
        findsOneWidget,
      );

      expect(
        find.text('Balls'),
        findsOneWidget,
      );

      expect(
        find.text('Bat'),
        findsOneWidget,
      );

      expect(
        find.text('0'),
        findsOneWidget,
      );

      expect(
        find.text('6'),
        findsOneWidget,
      );
    },
  );
}
