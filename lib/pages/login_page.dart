import 'package:flutter_login/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_login/flutter_login.dart';
import 'home_page.dart';

const users = const {
  'leianny@gmail.com': 12345,
  'gustavo@gmail.com': 12345,
};
//precisa vincular com o banco pra dar sequencia com a logica

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Email: ${data.name}, Senha: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Usuário não encontrado';
      }
      if (users[data.name] != data.password) {
        return 'Senha incorreta';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Nome de usuario: ${data.name}, Senha: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Nome: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Usuário não encontrado';
      }
      return 'Entre com sua senha';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'TO-DO LIST UNIVERSITÁRIO',
      //logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}