import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password) async {
    String res = "Un error a ocurrido";

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        //crea el usuario

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await _firestore.collection('user').doc(cred.user!.uid).set({
          'buyerId': cred.user!.uid,
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'address': '',
          'password': password,
        });

        res = 'Exito al crear el usuario';
      } else {
        res = 'Por favor los campos no deben de estar vacios';
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return res;
  }

  loginUsers(String email, String password) async {
    String res = 'Algo salio mal';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'Exito';
      } else {
        res = 'Por favor ingrese los datos';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
