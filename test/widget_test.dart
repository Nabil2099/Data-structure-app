import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:datastructure/main.dart';
import 'package:datastructure/core/models/topic.dart';
import 'package:datastructure/core/models/progress_models.dart';

void main() {
  testWidgets('App loads and shows bottom navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Should have bottom navigation with 5 items
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Learn'), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('AI Tutor'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
  });

  test('TopicProgress model works', () {
    final tp = TopicProgress(topic: DataStructureTopic.arrays);
    expect(tp.topic, DataStructureTopic.arrays);
    expect(tp.completionPercentage, 0);
  });

  test('DataStructureTopic display names', () {
    expect(DataStructureTopic.arrays.displayName, 'Arrays');
    expect(DataStructureTopic.stacks.displayName, 'Stacks');
    expect(DataStructureTopic.hashTables.displayName, 'Hash Tables');
  });
}
