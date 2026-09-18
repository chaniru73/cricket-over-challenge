import 'package:flutter_test/flutter_test.dart';
import 'package:cricket_target_challenge/main.dart';

void main() {
  testWidgets('Cricket Over Challenge loads correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CricketOverApp());

    expect(find.text('Cricket Over Challenge'), findsOneWidget);
    expect(find.text('Six-Ball Cricket'), findsOneWidget);
    expect(find.text('PLAY BALL'), findsOneWidget);
    expect(find.text('TOTAL SCORE'), findsOneWidget);
    expect(find.text('BALLS'), findsOneWidget);
    expect(find.text('0 / 6'), findsOneWidget);
  });
}
