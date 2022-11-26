import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../models/disciplina.dart';
import '../repositories/disciplina_repository.dart';
import '../repositories/selecionadas_repository.dart';

class AppBarTarefas extends StatefulWidget {
  TabBar tabBar;

  AppBarTarefas({super.key, required this.tabBar});

  @override
  State<AppBarTarefas> createState() => _AppBarTarefasState();
}

class _AppBarTarefasState extends State<AppBarTarefas> {
  late DisciplinaRepository drepository;
  late Selecionadas se;
  
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
    if(se.selecionadas.isEmpty) //Se lista de selecionadas estiver vazia, fica na AppBar padrão
    {
      return MaterialApp(
      localizationsDelegates: [S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
      ],
      home: SliverAppBar(
        title: Text(S.of(context).Tarefas),
        backgroundColor: Colors.deepOrange,
        pinned: true,
        floating: true,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.sort),
            itemBuilder: (context) => 
              drepository.lista.map((op) => 
                PopupMenuItem(
                  child: ListTile(
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
                    title: Text(op.nome),
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
        title: Text('${se.selecionadas.length}' + S.of(context).Selecionadas),
        actions: [
          PopupMenuButton(
            icon:
              Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline, color: Colors.green),
                  title: Text(S.of(context).Concluir),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  onTap: () {
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.highlight_remove_outlined, color: Colors.red),
                  title: Text(S.of(context).Remover),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  onTap: () {
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
