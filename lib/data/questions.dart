import 'package:quiz_app/model/quiz_question.dart';

const List<QuizQuestion> questions = [
  QuizQuestion(
    title: 'What are the main building block of Flutter UIs?',
    answers: [
      Answer(title: "Widget", correctAns: true),
      Answer(title: "Component"),
      Answer(title: "Block"),
      Answer(title: "Functions"),
    ],
  ),
  QuizQuestion(
    title: 'How are Flutter UIs built?',
    answers: [
      Answer(title: "By combining widgets in a visual editor"),
      Answer(title: "By combining widgets in code", correctAns: true),
      Answer(title: "By defining widgets in config files"),
      Answer(title: "By using XCode for iOS and Android Studio for Android"),
    ],
  ),
  QuizQuestion(
    title: 'What\'s the purpose of a StatefulWidget?',
    answers: [
      Answer(title: "Update UI as data changes", correctAns: true),
      Answer(title: "Update data as UI changes"),
      Answer(title: "Ignore data changes"),
      Answer(title: "Render UI that does not depend on data"),
    ],
  ),
  QuizQuestion(
    title:
        'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
    answers: [
      Answer(title: "StatelessWidget", correctAns: true),
      Answer(title: "StatefulWidget"),
      Answer(title: "Both are equally good"),
      Answer(title: "None of the above"),
    ],
  ),
  QuizQuestion(
    title: 'What happens if you change data in a StatelessWidget?',
    answers: [
      Answer(title: "The UI is not updated", correctAns: true),
      Answer(title: "The UI is updated"),
      Answer(title: "The closest StatefulWidget is updated"),
      Answer(title: "Any nested StatefulWidgets are updated"),
    ],
  ),
  QuizQuestion(
    title: 'How should you update data inside of StatefulWidgets?',
    answers: [
      Answer(title: "By calling setState()", correctAns: true),
      Answer(title: "By calling updateData()"),
      Answer(title: "By calling updateUI()"),
      Answer(title: "By calling updateState()"),
    ],
  ),
];
