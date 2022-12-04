import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/meu_aplicativo.dart';
import 'package:flutter_aula_1/pages/home_page.dart';
import 'package:flutter_aula_1/pages/loading_flashcard_page.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_aula_1/repositories/flashcard_repository.dart';
import 'package:flutter_aula_1/services/auth_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../pages/login_page.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    DisciplinaRepository drepository = Provider.of<DisciplinaRepository>(context);

    if (auth.isLoading) {
      return loading();
    } 
    else if (auth.usuario == null) {
      return LoginPage();
    } 
    else {
      return FutureBuilder(
        future: drepository.initalizeDisciplinas(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return LoadingFlashcardPage();
          } 
          else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator(color: Colors.deepOrange)),
            );
          }
        },
      );
    }
  }

  loading() {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
