import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flyhigh/auth/login_screen.dart';

void main() async {
  //agregar al inicio
  /*var db = DBconnect();
  db.addQuestion(
      QuestionCambri(id: '20', title: 'What is 20 * 100 ?', options: {
    '100': false,
    '200': true,
    '300': false,
    '500': false,
  }));
  db.fetchQuestions1();*/
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Question',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
