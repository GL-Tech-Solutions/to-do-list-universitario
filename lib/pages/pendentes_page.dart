import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/tarefa.dart';
import 'package:flutter_aula_1/widgets/tarefa_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PendentesPage extends StatefulWidget {
  final List<Tarefa> listaPendentes;

  const PendentesPage({
    super.key,
    required this.listaPendentes,
  });

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
      child: widget.listaPendentes.isEmpty
          ? ListTile(
              leading: Icon(Icons.notes),
              title: Text(AppLocalizations.of(context)!.naoHaTarefas),
            )
          : MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                itemCount: widget.listaPendentes.length,
                itemBuilder: (_, index) {
                  return TarefaCard(
                    tarefa: widget.listaPendentes[index],
                  );
                },
              ),
            ),
    );
  }
}
