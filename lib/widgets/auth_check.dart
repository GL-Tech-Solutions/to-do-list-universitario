import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/home_page.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_aula_1/repositories/flashcard_repository.dart';
import 'package:flutter_aula_1/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../pages/login_page.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return _loading();
    } else if (auth.usuario == null) {
      return LoginPage();
    } else {
      return FutureBuilder(
        future: _loadRepositories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _loading();
          }

          if (snapshot.data as bool) {
            return HomePage();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Um erro inesperado ocorreu. Por favor, tente novamente.'),
              ),
            );
            return LoginPage();
          }
        },
      );
    }
  }

  _loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> _loadRepositories() async {
    try {
      await context.read<DisciplinaRepository>().startRepository();
      // ignore: use_build_context_synchronously
      await context.read<FlashcardRepository>().startRepository();
      return true;
    } on Exception catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      return false;
    }
  }
}
