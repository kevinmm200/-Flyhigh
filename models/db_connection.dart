import 'dart:convert';

import 'package:flyhigh/models/questioncambri_model.dart';
import 'package:flyhigh/models/questionform_model.dart';
import 'package:http/http.dart' as http;
import './question_model.dart';
import './questiongram_model.dart';

class DBconnect {
  final url = Uri.parse(
      'https://quizapp-ec25a-default-rtdb.firebaseio.com/questions.json');
  final url1 = Uri.parse(
      'https://quizapp-ec25a-default-rtdb.firebaseio.com/questionsgram.json');
  final url2 = Uri.parse(
      'https://quizapp-ec25a-default-rtdb.firebaseio.com/questionsform.json');
  final url3 = Uri.parse(
      'https://quizapp-ec25a-default-rtdb.firebaseio.com/questionscambri.json');

  //funcion que agrega el modelo
  /*Future<void> addQuestion(QuestionCambri question) async {
    http.post(url3,
        body: json
            .encode({'title': question.title, 'options': question.options}));
  }*/

  Future<List<Question>> fetchQuestions() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
          id: key,
          title: value['title'],
          options: Map.castFrom(value['options']),
        );
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }

  Future<List<QuestionGram>> fetchQuestions1() async {
    return http.get(url1).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<QuestionGram> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = QuestionGram(
          id: key,
          title: value['title'],
          options: Map.castFrom(value['options']),
        );
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }

  Future<List<QuestionForm>> fetchQuestions2() async {
    return http.get(url2).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<QuestionForm> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = QuestionForm(
          id: key,
          title: value['title'],
          options: Map.castFrom(value['options']),
        );
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }

  Future<List<QuestionCambri>> fetchQuestions3() async {
    return http.get(url3).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<QuestionCambri> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = QuestionCambri(
          id: key,
          title: value['title'],
          options: Map.castFrom(value['options']),
        );
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }
}
