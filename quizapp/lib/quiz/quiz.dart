import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/quiz/congrates_page.dart';
import 'package:quizapp/quiz/question_page.dart';
import 'package:quizapp/quiz/quiz_provider.dart';
import 'package:quizapp/quiz/start_page.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/shared/loading.dart';
import 'package:quizapp/shared/progress_bar.dart';

class QuizScreen extends StatelessWidget {
  final String quizId;
  const QuizScreen({Key? key, required this.quizId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);

          if (!snapshot.hasData || snapshot.hasError) {
            return const Loader();
          } else {
            var quiz = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: ProgressBar(value: state.progress),
                leading: IconButton(
                  icon: const Icon(FontAwesomeIcons.xmark),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int idx) =>
                    state.progress = (idx / (quiz.questions.length + 1)),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return StartPage(quiz: quiz);
                  } else if (index == quiz.questions.length + 1) {
                    return CongratsPage(quiz: quiz);
                  } else {
                    return QuestionPage(question: quiz.questions[index - 1]);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
