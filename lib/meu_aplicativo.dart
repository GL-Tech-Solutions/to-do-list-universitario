import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/home_page.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas_repository.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas_repository.dart';
import 'package:flutter_aula_1/widgets/auth_check.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class MeuAplicativo extends StatelessWidget { //StatelessWidget - Um Widget imutável
  const MeuAplicativo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /*MaterialApp Class: MaterialApp is a predefined class in a flutter. It is likely the main or core component of flutter. 
    We can access all the other components and widgets provided by Flutter SDK. Text widget, Dropdownbutton widget, AppBar widget, Scaffold widget, ListView widget, 
    StatelessWidget, StatefulWidget, IconButton widget, TextField widget, Padding widget, ThemeData widget, etc. are the widgets that can be accessed using MaterialApp class. 
    There are many more widgets that are accessed using MaterialApp class. Using this widget, we can make an attractive app.*/
    return MaterialApp( 
      title: 'Todo List - Universitário', //Título App
      debugShowCheckedModeBanner: false,
      theme: ThemeData( //Tema do App. É possível definir sua cor, tema escuro / tema claro, etc
        primarySwatch: Colors.deepOrange //Cor do tema
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: AuthCheck(), //Página inicial. Aqui puxamos uma classe que possui uma página montada pelo Scaffold
    );
  }
}