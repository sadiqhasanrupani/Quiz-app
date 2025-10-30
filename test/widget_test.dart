// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/services/storage_service.dart';

import 'widget_test.mocks.dart';

// Generate mocks by running: flutter packages pub run build_runner build
@GenerateMocks([StorageService])
void main() {
  group('Main App Tests', () {
    late MockStorageService mockStorageService;

    setUp(() {
      mockStorageService = MockStorageService();
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn(null);
    });

    testWidgets('App loads and displays welcome screen', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp(storageService: mockStorageService));
      await tester.pumpAndSettle();

      // Verify that the welcome screen is displayed
      expect(find.text('Flutter Quiz Challenge'), findsOneWidget);
      expect(find.text('Start New Quiz'), findsOneWidget);
    });

    testWidgets('App supports dark mode', (WidgetTester tester) async {
      // Build our app in dark mode and trigger a frame.
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(platformBrightness: Brightness.dark),
          child: MyApp(storageService: mockStorageService),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the app loads in dark mode
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.darkTheme, isNotNull);
      expect(materialApp.themeMode, ThemeMode.system);
    });

    testWidgets('App has proper accessibility setup', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp(storageService: mockStorageService));
      await tester.pumpAndSettle();

      // Verify semantic label exists
      expect(find.bySemanticsLabel('Flutter Quiz Challenge App'), findsOneWidget);
    });
  });
}
