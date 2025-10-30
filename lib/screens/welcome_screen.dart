import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/quiz_controller.dart';
import '../models/quiz_result.dart';
import 'quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTablet = mediaQuery.size.width > 600;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    
    return Scaffold(
      body: SafeArea(
        child: Consumer<QuizController>(
          builder: (context, controller, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 64.0 : 24.0,
                        vertical: isLandscape ? 16.0 : 32.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // App Title with fade animation
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _AppTitle(isTablet: isTablet),
                          ),
                          
                          SizedBox(height: isLandscape ? 24 : 48),
                          
                          // Last Score Card with slide animation (if exists)
                          SlideTransition(
                            position: _slideAnimation,
                            child: _LastScoreCard(
                              controller: controller,
                              isTablet: isTablet,
                            ),
                          ),
                          
                          SizedBox(height: isLandscape ? 32 : 48),
                          
                          // Action Buttons with slide animation
                          SlideTransition(
                            position: _slideAnimation,
                            child: _ActionButtons(
                              controller: controller,
                              isTablet: isTablet,
                            ),
                          ),
                          
                          SizedBox(height: isLandscape ? 16 : 32),
                          
                          // App Description with fade animation
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _AppDescription(isTablet: isTablet),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AppTitle extends StatelessWidget {
  final bool isTablet;
  
  const _AppTitle({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'app_icon',
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.7),
                ],
              ),
            ),
            child: Icon(
              Icons.quiz,
              size: isTablet ? 80 : 60,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        Text(
          'Flutter Quiz Challenge',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 36 : 28,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 8),
        
        Text(
          'Test your knowledge and challenge yourself!',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
            fontSize: isTablet ? 18 : 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _LastScoreCard extends StatelessWidget {
  final QuizController controller;
  final bool isTablet;
  
  const _LastScoreCard({
    required this.controller,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final lastScore = controller.getLastScore();
    
    if (lastScore == null) {
      return const SizedBox.shrink();
    }
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Card(
        key: const ValueKey('last_score_card'),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Last Quiz Result',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ScoreItem(
                    label: 'Score',
                    value: '${lastScore.score}/${lastScore.totalQuestions}',
                    icon: Icons.score,
                  ),
                  _ScoreItem(
                    label: 'Percentage',
                    value: '${lastScore.percentage.toStringAsFixed(1)}%',
                    icon: Icons.percent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  
  const _ScoreItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor.withOpacity(0.7),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final QuizController controller;
  final bool isTablet;
  
  const _ActionButtons({
    required this.controller,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Start New Quiz Button
        Semantics(
          label: 'Start New Quiz Button',
          hint: 'Tap to begin a new quiz challenge',
          button: true,
          child: SizedBox(
            width: double.infinity,
            height: isTablet ? 56 : 48,
            child: ElevatedButton.icon(
              onPressed: controller.isLoading ? null : () async {
                await controller.startNewQuiz();
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizScreen(),
                    ),
                  );
                }
              },
              icon: controller.isLoading 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow),
              label: Text(
                controller.isLoading ? 'Loading...' : 'Start New Quiz',
                style: TextStyle(fontSize: isTablet ? 18 : 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
        
        // Resume Quiz Button (if resume data exists)
        if (controller.hasResumeData) ...[
          const SizedBox(height: 16),
          Semantics(
            label: 'Resume Quiz Button',
            hint: 'Tap to continue your previous quiz from where you left off',
            button: true,
            child: SizedBox(
              width: double.infinity,
              height: isTablet ? 56 : 48,
              child: OutlinedButton.icon(
                onPressed: controller.isLoading ? null : () async {
                  await controller.resumeQuiz();
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.refresh),
                label: Text(
                  'Resume Quiz',
                  style: TextStyle(fontSize: isTablet ? 18 : 16),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _AppDescription extends StatelessWidget {
  final bool isTablet;
  
  const _AppDescription({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.lightbulb_outline,
          color: Colors.grey[400],
          size: isTablet ? 32 : 24,
        ),
        const SizedBox(height: 8),
        
        Text(
          'Challenge yourself with our engaging quiz questions.\nTrack your progress and improve your knowledge!',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
            height: 1.5,
            fontSize: isTablet ? 16 : 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}