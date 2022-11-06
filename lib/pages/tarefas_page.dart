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
  //var tarefa = context.watch<ListarTarefas>();
  //var tarefa = Provider.of<ListarTarefas>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<ListarTarefas>().refresh()
          )
        ],
      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
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