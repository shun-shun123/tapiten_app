import 'package:flutter/material.dart';

class Answer extends ChangeNotifier {
  final String answerId;
  final String questionContent;
  final String answerChoise1;
  final String answerChoise2;

  Answer(
      {this.answerId,
      this.questionContent,
      this.answerChoise1,
      this.answerChoise2});

  Answer.dummy()
      : answerId = 'answerId',
        questionContent = "question Content",
        answerChoise1 = "answer choise 1",
        answerChoise2 = "answer choise 2";
}
