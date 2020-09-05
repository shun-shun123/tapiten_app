import 'package:flutter/material.dart';

class Answer {
  final String questionerId;
  final String questionContent;
  final String answer1;
  final String answer2;
  final int reviewScore;
  final int selectedAnswerIndex;

  Answer({
    @required this.questionerId,
    @required this.questionContent,
    @required this.answer1,
    @required this.answer2,
    @required this.reviewScore,
    @required this.selectedAnswerIndex,
  });
}
