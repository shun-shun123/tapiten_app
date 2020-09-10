import 'package:flutter/material.dart';

class Question {
  String answererId;
  String questionContent;
  String answer1;
  String answer2;
  String godMessage;
  int selectedAnswerIndex;

  Question({
    @required this.answererId,
    @required this.questionContent,
    @required this.answer1,
    @required this.answer2,
    @required this.godMessage,
    @required this.selectedAnswerIndex,
  });
}
