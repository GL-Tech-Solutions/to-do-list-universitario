import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/home_page.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:provider/provider.dart';
import '../repositories/tarefa_respository.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  //TODO! Fazer funcional para novos usuários
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Consumer<DisciplinaRepository>(
        builder: (context, disciplinas, child) {
          return disciplinas.listaInicial.isEmpty
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : Consumer<TarefaRepository>(
          builder: (context, tarefas, child) {
            return tarefas.listaPendentesInicial.isEmpty
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : HomePage();
            }
          );
        }
      )
    );
  }
}