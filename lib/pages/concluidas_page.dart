import 'package:flutter/material.dart';
import 'package:flutter_aula_1/widgets/tarefa_card.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../repositories/listar_tarefas_repository.dart';

class ConcluidasPage extends StatefulWidget {
  const ConcluidasPage({super.key});

  @override
  State<ConcluidasPage> createState() => _ConcluidasPageState();
}

class _ConcluidasPageState extends State<ConcluidasPage> {
  late ListarTarefasRepository tarefas;
  List<Tarefa> listaC = [];

  void listarConcluidas()
  {
    tarefas = context.watch<ListarTarefasRepository>();
    tarefas.lista.forEach((tarefa)
    { 
      if(!listaC.contains(tarefa) && tarefa.status == 'Finalizado') {
        listaC.add(tarefa);
      }
    });
   }

  @override
  Widget build(BuildContext context) {
    listarConcluidas();
    return Container(
      color: Colors.indigo.withOpacity(0.05),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8),
      child: 
        listaC.isEmpty
        ? ListTile(
          leading: Icon(Icons.notes),
          title: Text('Ainda não há Tarefas criadas'),
        )
        : MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
              itemCount: listaC.length,
              itemBuilder: (_, index) {
                return TarefaCard(tarefa: listaC[index]);
              },
            ),
        ),
      );
    }
}