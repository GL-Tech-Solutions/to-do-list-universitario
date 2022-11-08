import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas.dart';
import 'package:flutter_aula_1/widgets/tarefa_card.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../repositories/tarefa_respository.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late ListarTarefas tarefas;
  List<Tarefa> selecionadas = []; //Lista de tarefas selecionadas

  AppBar appBarDinamica()
  {
    if(selecionadas.isEmpty) //Se lista de selecionadas estiver vazia, fica na AppBar padrão
    {
      return AppBar(
        title: Text('Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: null,
          )
        ],
      );
    }
    else //Se lista de selecionadas não estiver vazia, fica na AppBar de selecionadas
    {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          }
        ),
        title: Text('${selecionadas.length} selecionadas'),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          color: Colors.black87,
           fontSize: 20,
           fontWeight: FontWeight.bold,
        )
      );
    }
  }

  void limparSelecionadas()
  {
    setState(() {
      selecionadas = [];
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDinamica(),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(8),
        child: Consumer<ListarTarefas>(
          builder: (context, tarefas, child) {
            return tarefas.lista.isEmpty
            ? ListTile(
              leading: Icon(Icons.notes),
              title: Text('Ainda não há Tarefas criadas'),
            )
            : ListView.builder(
                itemCount: tarefas.lista.length,
                itemBuilder: (_, index) {
                  return TarefaCard(tarefa: tarefas.lista[index]);
                },
              );
          },
        ),
      ),
    );
  }
}