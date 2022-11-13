import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/home_page.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas.dart';
import 'package:flutter_aula_1/repositories/provider_listar.dart';


class MeuAplicativo extends StatelessWidget { //StatelessWidget - Um Widget imutável
  const MeuAplicativo({Key? key}) : super(key: key);

  void iniciar()
  {
    ProviderListar providerListar = ProviderListar();
    ListarTarefas tarefas = ListarTarefas();
    tarefas.listarPendentes();
    tarefas.listarConcluidas();
  }

  @override
  Widget build(BuildContext context) {
    iniciar();
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
      home: HomePage(), //Página inicial. Aqui puxamos uma classe que possui uma página montada pelo Scaffold
    );
  }
}