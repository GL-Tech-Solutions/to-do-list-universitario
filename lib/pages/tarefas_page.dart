import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/tarefas_detalhes_page.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas_repository.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../repositories/disciplina_repository.dart';
import '../repositories/listar_tarefas_repository.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

//! Sperar widgets e métodos em outras classes o mais rápido possível
class _TarefasPageState extends State<TarefasPage> with SingleTickerProviderStateMixin {
  List<Tarefa> tabela = TarefaRepository.tabela;
  late ListarTarefasRepository tarefas;
  List<Tarefa> listaP = [];
  List<Tarefa> selecionadas = []; //Lista de tarefas selecionadas
  late TabController _controller;
  int abaAtual = 0;

  void concluirTarefa(int cod)
  {
    setState(() {
      (tabela[cod].status == 'Finalizado')
      ? tabela[cod].status = 'Aberto'
      : (tabela[cod].status == 'Aberto')
      ? tabela[cod].status = 'Finalizado' : null;
    });

  }

  setPaginaAtual(aba)
  {
    setState(() {
      abaAtual = aba;
    });
  }
  
  void listarPendentes()
  {
    tarefas.lista.forEach((tarefa)
    { 
      if(!listaP.contains(tarefa) && tarefa.status == 'Aberto') {
        listaP.add(tarefa);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //tarefas.listarPendentes();
    //tarefas.listarConcluidas();
    _controller = TabController(length: 2, vsync: this, animationDuration: Duration(milliseconds: 200));
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
      Tab(text: 'PENDENTES'),
      Tab(text: 'CONCLUÍDAS')
    ],
  );

  SliverAppBar appBarDinamica()
  {
    if(selecionadas.isEmpty) //Se lista de selecionadas estiver vazia, fica na AppBar padrão
    {
      return SliverAppBar(
        title: Text('Tarefas'),
        backgroundColor: Colors.deepOrange,
        pinned: true,
        floating: true,
        actions: [
          IconButton(
            icon: Icon(Icons.sort, color: Colors.white),
            onPressed: null,
          )
        ],
        bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: Material(
            color: Colors.white,
            child: _tabBar
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
            setState(() {
              selecionadas = [];
            });
          }
        ),
        title: Text('${selecionadas.length} selecionadas'),
        actions: [
          PopupMenuButton(
            icon:
              Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline, color: Colors.green),
                  title: Text('Concluir Tarefas'),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  onTap: () {
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.highlight_remove_outlined, color: Colors.red),
                  title: Text('Remover Tarefas'),
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

  abrirDetalhes(Tarefa tarefa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TarefasDetalhesPage(tarefa: tarefa),
      ),
    );
  }

  void limparSelecionadas()
  {
    setState(() {
      selecionadas = [];
    });
  }
  @override
  Widget build(BuildContext context) {
    // provider = Provider.of<ProviderListar>(context);
    tarefas = context.watch<ListarTarefasRepository>();

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                appBarDinamica(),
              ];
            },
            body: TabBarView(
              dragStartBehavior: DragStartBehavior.start,
              controller: _controller,
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  color: Colors.indigo.withOpacity(0.05),
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(8),
                  child: Consumer<ListarTarefasRepository>(
                    builder: (context, tarefas, child) {
                      listarPendentes();
                      return listaP.isEmpty
                      ? ListTile(
                        leading: Icon(Icons.notes),
                        title: Text('Ainda não há Tarefas criadas'),
                      )
                      : MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.builder(
                            itemCount: listaP.length,
                            itemBuilder: (_, index) {
                              return Card(
                                margin: EdgeInsets.only(top: 8),
                                elevation: 2,
                                child: InkWell(
                                  onTap: () { //Clicando em uma disciplina quando na lista de seleção, ela é selecionada. Porém se ela já está selecionada, ela é removida
                                        setState(() { //Altera o estado do widget, permitindo um rebuild
                                        if (selecionadas.isEmpty)
                                        {
                                          abrirDetalhes(listaP[index]);
                                        }
                                        else if (selecionadas.isNotEmpty && !selecionadas.contains(listaP[index]))
                                        {
                                          selecionadas.add(listaP[index]);
                                        }
                                        else if (selecionadas.contains(listaP[index]))
                                        {
                                          selecionadas.remove(listaP[index]);
                                        }
                                        });
                                      },
                                  onLongPress: () { //Pressionando em uma disciplina, ativa a lista de seleção e adiciona a disciplina pressionada na mesma
                                        setState(() {
                                          if (selecionadas.isEmpty)
                                          {
                                            selecionadas.add(listaP[index]);
                                          }
                                        });
                                      },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                                    decoration: BoxDecoration(
                                      color: (selecionadas.contains(listaP[index])) 
                                      ? Colors.indigoAccent.withOpacity(0.3) : null,
                                      border: (selecionadas.contains(listaP[index])) 
                                      ? Border(
                                        top: BorderSide(
                                          color: DisciplinaRepository.tabela[listaP[index].codDisciplina].cor, //Pega a cor selecionada da disciplina e a coloca na borda superior
                                          width: 5
                                        ),
                                        left: BorderSide(
                                          color: DisciplinaRepository.tabela[listaP[index].codDisciplina].cor,
                                          width: 2,
                                        ),
                                        right: BorderSide(
                                          color: DisciplinaRepository.tabela[listaP[index].codDisciplina].cor,
                                          width: 2,
                                        ),
                                        bottom: BorderSide(
                                          color: DisciplinaRepository.tabela[listaP[index].codDisciplina].cor,
                                          width: 2,
                                        )
                                      )
                                      : Border(
                                        top: BorderSide(
                                          color: DisciplinaRepository.tabela[listaP[index].codDisciplina].cor, //Pega a cor selecionada da disciplina e a coloca na borda superior
                                          width: 5
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        (selecionadas.isEmpty)
                                        ? IconButton(
                                            iconSize: 30,
                                            icon: (listaP[index].status == 'Aberto')
                                            ? Icon(Icons.circle_outlined)
                                            : Icon(Icons.check_circle, color: Colors.green),
                                            onPressed: () {
                                              concluirTarefa(listaP[index].cod);
                                              Provider.of<ListarTarefasRepository>(context, listen: false)
                                                      .refresh();
                                            } 
                                          )
                                        : (selecionadas.contains(listaP[index])) ?
                                          IconButton(
                                            icon: Icon(Icons.check_box_outlined, color: Colors.black),
                                            iconSize: 30,
                                            onPressed: null
                                          )
                                        : IconButton(
                                            icon: Icon(Icons.square_outlined, color: Colors.black),
                                            iconSize: 30,
                                            onPressed: null
                                          ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 2),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        listaP[index].nome,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w600,
                                                          decoration: (listaP[index].status == 'Finalizado') ? TextDecoration.lineThrough : null
                                                        ),
                                                      ),
                                                    ),
                                                    listaP[index].visibilidade
                                                    ? Container(
                                                        padding: EdgeInsets.all(2),
                                                        decoration: BoxDecoration(
                                                          color: Colors.green.withOpacity(0.2),
                                                          border: Border.all(
                                                            color: Colors.green,
                                                            width: 1
                                                          ),
                                                          borderRadius: BorderRadius.circular(100)
                                                        ),
                                                        child: Text(
                                                          'PÚBLICO',
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.green
                                                          ),
                                                        ),
                                                    )
                                                    : Container(
                                                        padding: EdgeInsets.all(2),
                                                        decoration: BoxDecoration(
                                                          color: Colors.red.withOpacity(0.2),
                                                          border: Border.all(
                                                            color: Colors.red,
                                                            width: 1
                                                          ),
                                                          borderRadius: BorderRadius.circular(100),
                                                        ),
                                                        child: Text(
                                                          'PRIVADO',
                                                          style: TextStyle(
                                                            fontSize: 9,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.red
                                                          ),
                                                        ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      listaP[index].tipo,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.date_range, size: 15, color: Colors.black54),
                                                        Text(
                                                          DateFormat('dd/MM/yyyy').format(listaP[index].data),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black45,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),                     
                                        PopupMenuButton(
                                          icon: (selecionadas.isEmpty)
                                            ? Icon(Icons.more_vert)
                                            : Icon(Icons.more_vert, size: 0),
                                          enabled: (selecionadas.isEmpty)
                                            ? true
                                            : false,
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: ListTile(
                                                leading: Icon(Icons.edit, color: Colors.blue),
                                                title: Text('Editar Tarefa'),
                                                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Provider.of<ListarTarefasRepository>(context, listen: false)
                                                      .remove(listaP[index]);
                                                },
                                              ),
                                            ),
                                            PopupMenuItem(
                                              child: ListTile(
                                                leading: Icon(Icons.highlight_remove_outlined, color: Colors.red),
                                                title: Text('Remover Tarefa'),
                                                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Provider.of<ListarTarefasRepository>(context, listen: false)
                                                      .remove(listaP[index]);
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      );
                    },
                  ),
                ),
                Icon(Icons.center_focus_weak_sharp),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            elevation: 5,
            backgroundColor: Colors.deepOrange[400],
            child: Icon(Icons.add, size: 30,)
            ),
        );
      //),
    //);
  }
}