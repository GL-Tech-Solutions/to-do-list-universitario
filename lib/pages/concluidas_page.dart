import 'package:flutter/material.dart';
import 'package:flutter_aula_1/widgets/tarefa_card.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../models/tarefa.dart';
import '../repositories/tarefa_respository.dart';

class ConcluidasPage extends StatefulWidget {
  final List<Tarefa> listaConcluidas;

  const ConcluidasPage({super.key, required this.listaConcluidas});

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
      child: widget.listaConcluidas.isEmpty
          ? ListTile(
              leading: Icon(Icons.notes),
              title: Text(S.of(context).NaoHaTarefas))
          : MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                itemCount: widget.listaConcluidas.length,
                itemBuilder: (_, index) {
                  return TarefaCard(
                    tarefa: widget.listaConcluidas[index],
                  );
                },
              ),
            ),
    );
  }
}
