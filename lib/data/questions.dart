import 'package:quiz_app/model/quiz_question.dart';

const List<QuizQuestion> questions = [
  QuizQuestion(
    title: 'What are the main building block of Flutter UIs?',
    answers: [
      Answer(titles: "Widget", correctAns: true),
      Answer(titles: "Component"),
      Answer(titles: "Block"),
      Answer(titles: "Functions"),
    ],
  ),
  QuizQuestion(
    title: 'How are Flutter UIs built?',
    answers: [
      Answer(titles: "By combining widgets in a visual editor"),
      Answer(titles: "By combining widgets in code", correctAns: true),
      Answer(titles: "By defining widgets in config files"),
      Answer(titles: "By using XCode for iOS and Android Studio for Android"),
    ],
  ),
  QuizQuestion(
    title: 'What\'s the purpose of a StatefulWidget?',
    answers: [
      Answer(titles: "Update UI as data changes", correctAns: true),
      Answer(titles: "Update data as UI changes"),
      Answer(titles: "Ignore data changes"),
      Answer(titles: "Render UI that does not depend on data"),
    ],
  ),
  QuizQuestion(
    title:
        'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
    answers: [
      Answer(titles: "StatelessWidget", correctAns: true),
      Answer(titles: "StatefulWidget"),
      Answer(titles: "Both are equally good"),
      Answer(titles: "None of the above"),
    ],
  ),
  QuizQuestion(
    title: 'What happens if you change data in a StatelessWidget?',
    answers: [
      Answer(titles: "The UI is not updated", correctAns: true),
      Answer(titles: "The UI is updated"),
      Answer(titles: "The closest StatefulWidget is updated"),
      Answer(titles: "Any nested StatefulWidgets are updated"),
    ],
  ),
  QuizQuestion(
    title: 'How should you update data inside of StatefulWidgets?',
    answers: [
      Answer(titles: "By calling setState()", correctAns: true),
      Answer(titles: "By calling updateData()"),
      Answer(titles: "By calling updateUI()"),
      Answer(titles: "By calling updateState()"),
    ],
  ),
];
