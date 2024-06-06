import 'package:flutter/material.dart';
import '../constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {super.key,
      required this.question,
      required this.indexAction,
      required this.totalQuestion});

  final String question;
  final int indexAction;
  final int totalQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        'Question ${indexAction + 1}/$totalQuestion: $question',
        style: const TextStyle(fontSize: 18.0, color: neutral),
      ),
    );
  }
}
