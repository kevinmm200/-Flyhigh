import 'package:flutter/material.dart';
import 'package:flyhigh/models/questioncambri_model.dart';
import '../../constants.dart';
import '../../widgets/question_widget.dart';
import '../../widgets/next_buttom.dart';
import '../../widgets/option_card.dart';
import '../../widgets/result_box.dart';
import '../../models/db_connection.dart';

class ExamCambriScreen extends StatefulWidget {
  const ExamCambriScreen({super.key});

  @override
  State<ExamCambriScreen> createState() => _ExamCambriScreenState();
}

class _ExamCambriScreenState extends State<ExamCambriScreen> {
  var db = DBconnect();
  /*final List<Question> _questions = [
    Question(
        id: '1',
        title: '¿Cuanto es 2 + 2?',
        options: {'5': false, '30': false, '4': true}),
    Question(
        id: '2',
        title: '¿Cuanto es 10 + 2?',
        options: {'5': false, '30': false, '14': true}),
  ];*/

  late Future _questions;

  Future<List<QuestionCambri>> getData() async {
    return db.fetchQuestions3();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  int index = 0;

  int score = 0;

  bool isPressed = false;

  bool isAlreadySelected = false;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: questionLength,
                onPressed: startOver,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select any option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<QuestionCambri>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<QuestionCambri>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: const Text('Quiz App'),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              // ignore: sized_box_for_whitespace
              body: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      QuestionWidget(
                          indexAction: index,
                          question: extractedData[index].title,
                          totalQuestion: extractedData.length),
                      const Divider(
                        color: neutral,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      for (int i = 0;
                          i < extractedData[index].options.length;
                          i++)
                        GestureDetector(
                          onTap: () => checkAnswerAndUpdate(
                              extractedData[index].options.values.toList()[i]),
                          child: OptionCard(
                            option:
                                extractedData[index].options.keys.toList()[i],
                            color: isPressed
                                ? extractedData[index]
                                            .options
                                            .values
                                            .toList()[i] ==
                                        true
                                    ? correct
                                    : incorrect
                                : neutral,
                          ),
                        )
                    ],
                  ),
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButtom(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Please wait while Quetions are loading...',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.none,
                      fontSize: 14.0),
                )
              ],
            ),
          );
        }
        return const Center(
          child: Text('No Questions'),
        );
      },
    );
  }
}
