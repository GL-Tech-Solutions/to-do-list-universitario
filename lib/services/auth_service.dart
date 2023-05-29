import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_aula_1/database/db_firestore.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String nome, String email, String password) async {
    try {
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await newUser.user?.updateDisplayName(nome);
      final db = DBFirestore.get();
      await db.collection('aceiteInfo/').doc(newUser.user?.uid).set(
        {
          'dataDeAceite': DateTime.now(),
        },
      );
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('weak-password');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('email-already-in-use');
      } else if (e.code == 'invalid-email') {
        throw AuthException('invalid-email');
      }
    }
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('user-not-found');
      } else if (e.code == 'wrong-password') {
        throw AuthException('wrong-password');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
