import 'package:flutter/material.dart';
import 'package:flyhigh/constants.dart';
import 'package:flyhigh/screens/pages/exam_cambri_screen%20.dart';
import 'package:flyhigh/screens/pages/exam_ecl_screen.dart';
import 'package:flyhigh/screens/pages/exam_form_screen.dart';
import 'package:flyhigh/screens/pages/exam_gram_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        centerTitle: true,
        title: const Text(
          'Bienvenido',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'A continuación encontrarás formularios y unidades de aprendizaje ofrecidos para potenciar el nivel de inglés'),
          ),
          // Primera Card
          Card(
            child: ListTile(
              leading: const Icon(Icons.book), // Icono de usuario
              title: const Text('Exam Ecl'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExamScreen(),
                  ),
                );
              },
            ),
          ),
          // Segunda Card
          Card(
            child: ListTile(
              leading: const Icon(Icons.book), // Icono de usuario
              title: const Text('Exam Form 84'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExamFormScreen(),
                  ),
                );
              },
            ),
          ),
          // Tercera Card
          Card(
            child: ListTile(
              leading: const Icon(Icons.book), // Icono de usuario
              title: const Text('Exam Cambridge'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExamCambriScreen(),
                  ),
                );
              },
            ),
          ),
          // Cuarta Card
          Card(
            child: ListTile(
              leading: const Icon(Icons.book), // Icono de usuario
              title: const Text('Exam Grammar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExamGramScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
