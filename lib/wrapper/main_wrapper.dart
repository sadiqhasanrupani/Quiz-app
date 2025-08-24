import 'package:flutter/material.dart';

/// A simple app wrapper that provides the global `MaterialApp` + background
/// decoration. The content shown inside the decorated container can be
/// supplied either via `child` or via `builder`.
///
/// Examples:
///   - `MainWrapper(child: HomePage())`
///   - `MainWrapper(builder: (ctx) => QuestionPage(...))`
class MainWrapper extends StatelessWidget {
  // if provided, this widget will be place inside the decorated container.
  final Widget? child;

  // function to create a widget lazily.
  final Widget Function(BuildContext context)? builder;

  /// Optional app title override
  final String title;

  const MainWrapper({
    super.key,
    this.child,
    this.builder,
    this.title = "Quiz App",
  });

  @override
  Widget build(BuildContext context) {
    // Resolve content: builder takes precedence over child.
    final Widget content =
        builder?.call(context) ??
        child ??
        const Center(child: Text("No Content Provided"));

    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 173, 47, 196),
                const Color.fromARGB(255, 116, 19, 133),
                const Color.fromARGB(255, 89, 12, 102),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}
