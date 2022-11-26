import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/disciplina.dart';
import '../repositories/disciplina_repository.dart';
import '../repositories/selecionadas_repository.dart';
import '../repositories/tarefa_respository.dart';

class AppBarTarefas extends StatefulWidget {
  TabBar tabBar;

  AppBarTarefas({super.key, required this.tabBar});

  @override
  State<AppBarTarefas> createState() => _AppBarTarefasState();
}

class _AppBarTarefasState extends State<AppBarTarefas> {
  late DisciplinaRepository drepository;
  late Selecionadas se;
  late TarefaRepository trepository;
  
  String getInitials(String disciplineName) {
    var buffer = StringBuffer();
    var split = disciplineName.split(' ');
    String initial = "";
    int limit = 0;

    for (int i=0; i<split.length; i++) 
    {
      initial = split[i][0];
      if (initial == initial.toUpperCase())
      {
        buffer.write(initial);
        limit++;
        if (limit == 2)
          break;
      }
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    se = context.watch<Selecionadas>();
    drepository = context.read<DisciplinaRepository>();
    trepository = context.watch<TarefaRepository>();

    if(se.selecionadas.isEmpty) //Se lista de selecionadas estiver vazia, fica na AppBar padrão
    {
      return SliverAppBar(
        title: Text('Tarefas'),
        backgroundColor: Colors.deepOrange,
        pinned: true,
        floating: true,
        actions: [
          TextButton(
            onPressed: trepository.cod == null ? null :
              (() => Provider.of<TarefaRepository>(context, listen: false).clearFiltered()),
            child: trepository.cod == null ? Text('') :
              Text(
                'LIMPAR FILTROS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                )
              )
          ),
          PopupMenuButton(
            icon: Icon(Icons.sort),
            itemBuilder: (context) => 
              drepository.lista.map((op) => 
                PopupMenuItem(
                  onTap: (() => Provider.of<TarefaRepository>(context, listen: false).cod = op.cod),
                  child: ListTile(
                    tileColor: trepository.cod == op.cod ? Colors.deepOrange.withOpacity(0.8) : null,
                    shape: RoundedRectangleBorder( //Ajusta os componentes da lista para um formato circular
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: op.cor,
                      child: Text(
                        getInitials(op.nome),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: trepository.cod != op.cod ? Text(op.nome) :
                      Text(
                        op.nome,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                      )
                  ),
                )).toList(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: widget.tabBar.preferredSize,
          child: Material(
            color: Colors.white,
            child: widget.tabBar
          ),
        ),
      );
    }
    else //Se lista de selecionadas não estiver vazia, fica na AppBar de selecionadas
    {
      return SliverAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () {
            Provider.of<Selecionadas>(context, listen: false).limparSelecionadas();
          }
        ),
        title: Text('${se.selecionadas.length} selecionadas'),
        actions: [
          PopupMenuButton(
            icon:
              Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.swap_horizontal_circle_sharp, color: Colors.blue),
                  title: Text('Alterar Status das Tarefas'),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  onTap: () {
                    Provider.of<TarefaRepository>(context, listen: false).setStatus(se.selecionadas);
                    Provider.of<Selecionadas>(context, listen: false).limparSelecionadas();
                    Navigator.pop(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.highlight_remove_outlined, color: Colors.red),
                  title: Text('Remover Tarefas'),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  onTap: () {
                    Provider.of<TarefaRepository>(context, listen: false).remove(se.selecionadas);
                    Provider.of<Selecionadas>(context, listen: false).limparSelecionadas();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
        backgroundColor: Colors.blueGrey[100],
        pinned: true,
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
}
