import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';
import 'package:flutter_aula_1/widgets/tarefa_card.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../models/tarefa.dart';
import '../repositories/listar_tarefas_repository.dart';

class PendentesPage extends StatefulWidget {
  const PendentesPage({super.key});

  @override
  State<PendentesPage> createState() => _PendentesPageState();
}

class _PendentesPageState extends State<PendentesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.withOpacity(0.05),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8),
      child: 
        Consumer<TarefaRepository>(
          builder: (context, tarefas, child) {
            return tarefas.listaPendentes.isEmpty
            ? ListTile(
              leading: Icon(Icons.notes),
              title: Text(S.of(context).NaoHaTarefas),
            )
            : MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                itemCount: tarefas.listaPendentes.length,
                itemBuilder: (_, index) {
                  //TODO Deixar um if e else if para receber o filtro de disciplinas depois
                    return TarefaCard(tarefa: tarefas.listaPendentes[index]);
                },
              ),
            );
        }
      )
    );
  }
}
