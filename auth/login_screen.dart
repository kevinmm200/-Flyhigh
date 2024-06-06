import 'package:flutter/material.dart';
import 'package:flyhigh/auth/register_screen.dart';
import 'package:flyhigh/controllers/auth_controllers.dart';
import 'package:flyhigh/screens/main_screen.dart';
import 'package:flyhigh/utils/show_snackBarg.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;

  late String password;

  bool _isLoading = false;

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      String res = await _authController.loginUsers(email, password);

      if (res == 'Exito') {
        // ignore: use_build_context_synchronously
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const MainScreen();
        }));
      } else {
        // ignore: use_build_context_synchronously
        return showSnack(context, res);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Correo o Contraseña incorrectos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [
                SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset('assets/images/logo1.png')),
              ],
            ),
            SizedBox(
                width: 150,
                height: 150,
                child: Image.asset('assets/images/logo.png')),
            const Text(
              'Hola, Bienvenido de nuevo.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa tu Correo Electronico';
                  } else {
                    return null;
                  }
                },
                onChanged: ((value) {
                  email = value;
                }),
                decoration: const InputDecoration(
                  labelText: 'Correo Electronico',
                  labelStyle: TextStyle(color: neutral),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa tu Contraseña';
                  } else {
                    return null;
                  }
                },
                onChanged: ((value) {
                  password = value;
                }),
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: neutral),
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            InkWell(
              onTap: () {
                _loginUsers();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 40,
                decoration: BoxDecoration(
                  color: neutral,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : const Text(
                          'Acceso',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No tienes una Cuenta?',
                    style: TextStyle(color: neutral),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const RegisterScreen();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Registro',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    width: 200,
                    height: 80,
                    child: Image.asset('assets/images/logo2.png')),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
