import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyhigh/auth/login_screen.dart';
import 'package:flyhigh/constants.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      // Navegar a la pantalla de inicio de sesión
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    }).catchError((error) {
                      // Manejar errores, si los hay
                      // ignore: avoid_print
                      print("Error al cerrar sesión: $error");
                    });
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 24.0, color: incorrect),
                  )),
            ),
          ]),
    );
  }
}
