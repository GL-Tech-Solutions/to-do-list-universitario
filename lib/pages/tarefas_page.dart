import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/tarefas_detalhes_page.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../repositories/disciplina_repository.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late ListarTarefas tarefas;
  List<Tarefa> selecionadas = []; //Lista de tarefas selecionadas
  int abaAtual = 0;

  /*@override
  void initState() {
    super.initState();
    tarefas.listarPendentes();
    tarefas.listarConcluidas();
    print(tarefas.listaP);
    print(tarefas.listaC);
  }*/

  setPaginaAtual(aba)
  {
    setState(() {
      abaAtual = aba;
    });
  }

  TabBar get _tabBar => TabBar(
    indicatorColor: Colors.deepOrange[400],
    indicatorWeight: 3,
    labelColor: abaAtual == 0 ? Colors.red[800] : Colors.green,
    unselectedLabelColor: Colors.black,
    labelStyle: TextStyle(fontWeight: FontWeight.w600),
    onTap: (index) { // It gives current selected index 0 for First Tab , second 1, like....
      setPaginaAtual(index);
    },
    tabs: [
      Tab(text: 'PENDENTES'),
      Tab(text: 'CONCLUÍDAS')
    ],
  );

  AppBar appBarDinamica()
  {
    if(selecionadas.isEmpty) //Se lista de selecionadas estiver vazia, fica na AppBar padrão
    {
      return AppBar(
        title: Text('Tarefas'),
        backgroundColor: Colors.deepOrange,
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
      return AppBar(
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
        bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: Material(
            color: Colors.white,
            child: _tabBar
          ),
        ),
        backgroundColor: Colors.blueGrey[50],
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
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: abaAtual,
        length: 2, 
        animationDuration: Duration(milliseconds: 200),
        child: Scaffold(
          appBar: appBarDinamica(),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                color: Colors.indigo.withOpacity(0.05),
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(8),
                child: Consumer<ListarTarefas>(
                  builder: (context, tarefas, child) {
                    tarefas.listarPendentes();
                    tarefas.listarConcluidas();
                    return tarefas.lista.isEmpty
                    ? ListTile(
                      leading: Icon(Icons.notes),
                      title: Text('Ainda não há Tarefas criadas'),
                    )
                    : ListView.builder(
                        itemCount: tarefas.lista.length,
                        itemBuilder: (_, index) {
                          return Card(
                            margin: EdgeInsets.only(top: 8),
                            elevation: 2,
                            child: InkWell(
                              onTap: () { //Clicando em uma disciplina quando na lista de seleção, ela é selecionada. Porém se ela já está selecionada, ela é removida
                                    setState(() { //Altera o estado do widget, permitindo um rebuild
                                    if (selecionadas.isEmpty)
                                    {
                                      abrirDetalhes(tarefas.lista[index]);
                                    }
                                    else if (selecionadas.isNotEmpty && !selecionadas.contains(tarefas.lista[index]))
                                    {
                                      selecionadas.add(tarefas.lista[index]);
                                    }
                                    else if (selecionadas.contains(tarefas.lista[index]))
                                    {
                                      selecionadas.remove(tarefas.lista[index]);
                                    }
                                    });
                                  },
                              onLongPress: () { //Pressionando em uma disciplina, ativa a lista de seleção e adiciona a disciplina pressionada na mesma
                                    setState(() {
                                      if (selecionadas.isEmpty)
                                      {
                                        selecionadas.add(tarefas.lista[index]);
                                      }
                                    });
                                  },
                              child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                                decoration: BoxDecoration(
                                  color: (selecionadas.contains(tarefas.lista[index])) 
                                  ? Colors.indigoAccent.withOpacity(0.3) : null,
                                  border: (selecionadas.contains(tarefas.lista[index])) 
                                  ? Border(
                                    top: BorderSide(
                                      color: DisciplinaRepository.tabela[tarefas.lista[index].codDisciplina].cor, //Pega a cor selecionada da disciplina e a coloca na borda superior
                                      width: 5
                                    ),
                                    left: BorderSide(
                                      color: DisciplinaRepository.tabela[tarefas.lista[index].codDisciplina].cor,
                                      width: 2,
                                    ),
                                    right: BorderSide(
                                      color: DisciplinaRepository.tabela[tarefas.lista[index].codDisciplina].cor,
                                      width: 2,
                                    ),
                                    bottom: BorderSide(
                                      color: DisciplinaRepository.tabela[tarefas.lista[index].codDisciplina].cor,
                                      width: 2,
                                    )
                                  )
                                  : Border(
                                    top: BorderSide(
                                      color: DisciplinaRepository.tabela[tarefas.lista[index].codDisciplina].cor, //Pega a cor selecionada da disciplina e a coloca na borda superior
                                      width: 5
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    (selecionadas.isEmpty)
                                    ? Icon(
                                        Icons.circle_outlined,
                                        size: 30,
                                      )
                                    : (selecionadas.contains(tarefas.lista[index])) ?
                                      Icon(
                                        Icons.check_box_outlined,
                                        size: 30,
                                      )
                                    : Icon(
                                        Icons.square_outlined,
                                        size: 30,
                                      ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    tarefas.lista[index].nome,
                                                    style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                tarefas.lista[index].visibilidade
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
                                                  tarefas.lista[index].tipo,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('dd/MM/yyyy').format(tarefas.lista[index].data),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black45,
                                                  ),
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
                                              Provider.of<ListarTarefas>(context, listen: false)
                                                  .remove(tarefas.lista[index]);
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
                                              Provider.of<ListarTarefas>(context, listen: false)
                                                  .remove(tarefas.lista[index]);
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
                      );
                  },
                ),
              ),
              Icon(Icons.center_focus_weak_sharp),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            elevation: 5,
            backgroundColor: Colors.deepOrange[400],
            child: Icon(Icons.add, size: 30,)
            ),
        ),
      ),
    );
  }
}