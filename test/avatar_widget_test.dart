import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweat_pals/src/features/gamification/sweat_pal_avatar.dart';
import 'package:sweat_pals/src/providers/avatar_provider.dart';

void main() {
  testWidgets('SweatPalAvatar renders correctly', (WidgetTester tester) async {
    const avatarState = AvatarState(
      mood: AvatarMood.happy,
      level: 1,
      primaryColor: Colors.blue,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SweatPalAvatar(state: avatarState, size: 200),
          ),
        ),
      ),
    );

    // Verify CustomPaint with PerformancePulsePainter exists
    expect(
      find.byWidgetPredicate(
        (widget) => widget is CustomPaint && widget.painter is PerformancePulsePainter,
      ),
      findsOneWidget,
    );
    
    // Pump some frames to check animation doesn't crash
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
  });
}
