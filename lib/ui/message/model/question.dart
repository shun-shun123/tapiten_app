import 'package:flutter/material.dart';

class Question {
  final String answererId;
  final String questionContent;
  final String answer1;
  final String answer2;
  final String godMessage;
  final int selectedAnswerIndex;

  Question({
    @required this.answererId,
    @required this.questionContent,
    @required this.answer1,
    @required this.answer2,
    @required this.godMessage,
    @required this.selectedAnswerIndex,
  });
}
