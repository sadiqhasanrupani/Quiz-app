import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/models/quiz_result.dart';
import 'package:quiz_app/screens/welcome_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/services/storage_service.dart';

import 'welcome_screen_test.mocks.dart';

// Generate mocks by running: flutter packages pub run build_runner build
@GenerateMocks([StorageService])
void main() {
  group('WelcomeScreen Widget Tests', () {
    late MockStorageService mockStorageService;
    late QuizController quizController;

    setUp(() {
      mockStorageService = MockStorageService();
      quizController = QuizController(mockStorageService);
    });

    Widget createWidgetUnderTest() {
      return ChangeNotifierProvider<QuizController>.value(
        value: quizController,
        child: MaterialApp(
          home: const WelcomeScreen(),
          routes: {
            '/quiz': (context) => const QuizScreen(),
          },
        ),
      );
    }

    testWidgets('displays app title and description', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Flutter Quiz Challenge'), findsOneWidget);
      expect(find.text('Test your knowledge and challenge yourself!'), findsOneWidget);
      expect(find.text('Challenge yourself with our engaging quiz questions.\nTrack your progress and improve your knowledge!'), findsOneWidget);
    });

    testWidgets('displays start new quiz button', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Start New Quiz'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      
      // Check button is enabled
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('displays last score when available', (WidgetTester tester) async {
      // Arrange
      final lastScore = QuizResult(
        score: 4,
        totalQuestions: 5,
        timestamp: DateTime.now(),
        timeTaken: const Duration(minutes: 2, seconds: 30),
      );
      when(mockStorageService.getLastScore()).thenReturn(lastScore);
      when(mockStorageService.getResumeData()).thenReturn(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Last Quiz Result'), findsOneWidget);
      expect(find.text('4/5'), findsOneWidget);
      expect(find.text('80.0%'), findsOneWidget);
      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('displays resume button when resume data exists', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn({
        'currentQuestion': 2,
        'answers': [0, 1, null],
        'startTime': DateTime.now().toIso8601String(),
      });

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Resume Quiz'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
      
      // Check both buttons are present
      expect(find.text('Start New Quiz'), findsOneWidget);
      expect(find.text('Resume Quiz'), findsOneWidget);
    });

    testWidgets('does not display resume button when no resume data', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Resume Quiz'), findsNothing);
      expect(find.text('Start New Quiz'), findsOneWidget);
    });

    testWidgets('navigates to quiz screen when start button is tapped', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn(null);
      when(mockStorageService.clearResumeData()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      
      // Tap the start button
      await tester.tap(find.text('Start New Quiz'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(QuizScreen), findsOneWidget);
      verify(mockStorageService.clearResumeData()).called(1);
    });

    testWidgets('navigates to quiz screen when resume button is tapped', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn({
        'currentQuestion': 2,
        'answers': [0, 1, null],
        'startTime': DateTime.now().toIso8601String(),
      });

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      
      // Tap the resume button
      await tester.tap(find.text('Resume Quiz'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(QuizScreen), findsOneWidget);
    });

    testWidgets('displays loading state when quiz is being loaded', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn(null);
      when(mockStorageService.clearResumeData()).thenAnswer((_) async {
        // Add delay to simulate loading
        await Future.delayed(const Duration(milliseconds: 100));
      });

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      
      // Tap the start button
      await tester.tap(find.text('Start New Quiz'));
      await tester.pump(); // Don't wait for settle to catch loading state

      // Assert loading state
      expect(find.text('Loading...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Wait for loading to complete
      await tester.pumpAndSettle();
      expect(find.byType(QuizScreen), findsOneWidget);
    });

    testWidgets('displays correct semantic labels for accessibility', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn({
        'currentQuestion': 1,
        'answers': [0],
        'startTime': DateTime.now().toIso8601String(),
      });

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert semantic labels exist
      expect(
        find.bySemanticsLabel('Start New Quiz Button'),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel('Resume Quiz Button'),
        findsOneWidget,
      );
    });

    testWidgets('hero animation is present for app icon', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Hero), findsOneWidget);
      final hero = tester.widget<Hero>(find.byType(Hero));
      expect(hero.tag, 'app_icon');
    });

    testWidgets('responsive design adjusts for tablet screens', (WidgetTester tester) async {
      // Arrange
      when(mockStorageService.getLastScore()).thenReturn(null);
      when(mockStorageService.getResumeData()).thenReturn(null);

      // Act - Set tablet size
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert - Check that larger elements are rendered (we can verify by checking button heights)
      final buttons = tester.widgetList<SizedBox>(
        find.descendant(
          of: find.byType(ElevatedButton),
          matching: find.byType(SizedBox),
        ),
      );
      
      // Should find at least one SizedBox with tablet height (56)
      expect(
        buttons.any((sizedBox) => sizedBox.height == 56),
        isTrue,
      );
      
      // Clean up
      addTearDown(tester.view.reset);
    });

    testWidgets('displays both last score and resume data when both exist', (WidgetTester tester) async {
      // Arrange
      final lastScore = QuizResult(
        score: 3,
        totalQuestions: 5,
        timestamp: DateTime.now(),
        timeTaken: const Duration(minutes: 1, seconds: 45),
      );
      when(mockStorageService.getLastScore()).thenReturn(lastScore);
      when(mockStorageService.getResumeData()).thenReturn({
        'currentQuestion': 1,
        'answers': [2],
        'startTime': DateTime.now().toIso8601String(),
      });

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Last Quiz Result'), findsOneWidget);
      expect(find.text('3/5'), findsOneWidget);
      expect(find.text('60.0%'), findsOneWidget);
      expect(find.text('Start New Quiz'), findsOneWidget);
      expect(find.text('Resume Quiz'), findsOneWidget);
    });
  });
}