import 'package:flutter/material.dart';
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
  late ListarTarefasRepository tarefas;
  List<Tarefa> listaP = [];

  void listarPendentes()
  {
    tarefas = context.watch<ListarTarefasRepository>();
    tarefas.lista.forEach((tarefa)
    { 
      if(!listaP.contains(tarefa) && tarefa.status == S.of(context).Aberto) {
        listaP.add(tarefa);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    listarPendentes();
    return /*MaterialApp(
      localizationsDelegates: [S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      home:*/ Container(
      color: Colors.indigo.withOpacity(0.05),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8),
      child: 
        listaP.isEmpty
        ? ListTile(
          leading: Icon(Icons.notes),
          title: Text(S.of(context).NaoHaTarefas),
        )
        : MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
              itemCount: listaP.length,
              itemBuilder: (_, index) {
                return TarefaCard(tarefa: listaP[index]);
              },
            ),
        ),
      //),
      );
    }
  }
