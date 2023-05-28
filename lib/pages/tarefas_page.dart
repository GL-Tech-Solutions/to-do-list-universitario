import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/adicionar_tarefa_page.dart';
import 'package:flutter_aula_1/pages/concluidas_page.dart';
import 'package:flutter_aula_1/pages/pendentes_page.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';
import 'package:flutter_aula_1/widgets/appbar_tarefas.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int abaAtual = 0;

  setPaginaAtual(aba) {
    setState(() {
      abaAtual = aba;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        length: 2, vsync: this, animationDuration: Duration(milliseconds: 200));
    _controller.animation?.addListener(() {
      setPaginaAtual(_controller.index);
    });
  }

  TabBar get _tabBar => TabBar(
        indicatorColor: Colors.deepOrange[400],
        indicatorWeight: 3,
        labelColor: abaAtual == 0 ? Colors.red[800] : Colors.green,
        unselectedLabelColor: Colors.black.withOpacity(0.7),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        controller: _controller,
        tabs: [
          Tab(text: AppLocalizations.of(context)!.pendentes),
          Tab(text: AppLocalizations.of(context)!.concluidas)
        ],
      );

  adicionarTarefa() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdiconarTarefaPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AppBarTarefas(tabBar: _tabBar),
          ];
        },
        body: Consumer<TarefaRepository>(
          builder:
              (BuildContext context, TarefaRepository tarefas, Widget? child) {
            return FutureBuilder(
              future: tarefas.codDisciplinaFilter == null
                  ? context.read<TarefaRepository>().readTarefas()
                  : context
                      .read<TarefaRepository>()
                      .readFiltered(tarefas.codDisciplinaFilter),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    ),
                  );
                }

                List<Tarefa> tarefasPendentes = (snapshot.data as List<Tarefa>)
                    .where((tarefa) => tarefa.status == 'Aberto')
                    .toList();
                List<Tarefa> tarefasConcluidas = (snapshot.data as List<Tarefa>)
                    .where((tarefa) => tarefa.status == 'Finalizado')
                    .toList();

                return TabBarView(
                  dragStartBehavior: DragStartBehavior.start,
                  controller: _controller,
                  physics: ClampingScrollPhysics(),
                  children: [
                    PendentesPage(
                      listaPendentes: tarefasPendentes,
                    ),
                    ConcluidasPage(
                      listaConcluidas: tarefasConcluidas,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (() => adicionarTarefa()),
          elevation: 5,
          backgroundColor: Colors.deepOrange[400],
          child: Icon(
            Icons.add,
            size: 30,
          )),
    );
  }
}
