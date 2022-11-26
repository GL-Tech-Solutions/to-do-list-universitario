import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n.dart';
import '../models/tarefa.dart';

class TarefasDetalhesPage extends StatelessWidget {
  Tarefa tarefa;

  TarefasDetalhesPage({Key? key, required this.tarefa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(
      localizationsDelegates: [S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      home: */Scaffold(

      //),
    );
    
  }
}