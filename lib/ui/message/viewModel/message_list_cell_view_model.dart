import 'package:flutter/material.dart';

class Answer extends ChangeNotifier {
  final String questionerId;
  final String questionContent;
  final String answer1;
  final String answer2;
  final int reviewScore;
  final int selectedAnswerIndex;

  Answer({
    this.questionerId,
    this.questionContent,
    this.answer1,
    this.answer2,
    this.reviewScore,
    this.selectedAnswerIndex,
  });
}

class Question extends ChangeNotifier {
  final String answererId;
  final String questionContent;
  final String answer1;
  final String answer2;
  final String godMessage;
  final int selectedAnswerIndex;

  Question({
    this.answererId,
    this.questionContent,
    this.answer1,
    this.answer2,
    this.godMessage,
    this.selectedAnswerIndex,
  });
}
