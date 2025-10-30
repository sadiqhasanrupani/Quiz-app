import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/quiz_controller.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quiz Challenge'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<QuizController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!controller.isQuizActive || controller.currentQuestion == null) {
            return const Center(
              child: Text('No active quiz. Please return to welcome screen.'),
            );
          }

          final question = controller.currentQuestion!;
          final progress = (controller.currentQuestionIndex + 1) / controller.totalQuestions;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress bar
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Question number
                Text(
                  'Question ${controller.currentQuestionIndex + 1} of ${controller.totalQuestions}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Question text
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      question.text,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Answer options
                Expanded(
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      final isSelected = controller.userAnswers.length > controller.currentQuestionIndex &&
                          controller.userAnswers[controller.currentQuestionIndex] == index;
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(question.options[index]),
                          leading: Radio<int>(
                            value: index,
                            groupValue: controller.userAnswers.length > controller.currentQuestionIndex 
                                ? controller.userAnswers[controller.currentQuestionIndex] 
                                : null,
                            onChanged: (value) {
                              if (value != null) {
                                controller.answerQuestion(value);
                              }
                            },
                          ),
                          selected: isSelected,
                          onTap: () => controller.answerQuestion(index),
                        ),
                      );
                    },
                  ),
                ),
                
                // Navigation buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous button
                    ElevatedButton(
                      onPressed: controller.currentQuestionIndex > 0
                          ? controller.previousQuestion
                          : null,
                      child: const Text('Previous'),
                    ),
                    
                    // Next/Finish button
                    ElevatedButton(
                      onPressed: controller.userAnswers.length > controller.currentQuestionIndex &&
                              controller.userAnswers[controller.currentQuestionIndex] != null
                          ? () async {
                              if (controller.isLastQuestion) {
                                // Finish quiz
                                final result = await controller.finishQuiz();
                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(result: result),
                                    ),
                                  );
                                }
                              } else {
                                controller.nextQuestion();
                              }
                            }
                          : null,
                      child: Text(controller.isLastQuestion ? 'Finish' : 'Next'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}