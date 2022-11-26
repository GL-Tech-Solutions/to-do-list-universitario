import 'package:flutter/material.dart';
import 'package:flutter_aula_1/widgets/tarefa_card.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../models/tarefa.dart';
import '../repositories/listar_tarefas_repository.dart';
import '../repositories/tarefa_respository.dart';

class ConcluidasPage extends StatefulWidget {
  const ConcluidasPage({super.key});

  @override
  State<ConcluidasPage> createState() => _ConcluidasPageState();
}

class _ConcluidasPageState extends State<ConcluidasPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.withOpacity(0.05),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8),
      child: 
        Consumer<TarefaRepository>(
          builder:(context, tarefas, child) {
            return tarefas.listaConcluidas.isEmpty
          ? ListTile(
            leading: Icon(Icons.notes),
            title: Text(S.of(context).NaoHaTarefas)),
          )
          : MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.builder(
                itemCount: tarefas.listaConcluidas.length,
                itemBuilder: (_, index) {
                  //TODO Deixar um if e else if para receber o filtro de disciplinas depois
                  return TarefaCard(tarefa: tarefas.listaConcluidas[index]);
                },
              ),
            );
          },
        ),
      //),
      );
    }
}