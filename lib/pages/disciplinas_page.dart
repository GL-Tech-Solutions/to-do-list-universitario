import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/disciplina.dart';
import 'package:flutter_aula_1/pages/editar_disciplina_page.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';
import 'package:flutter_aula_1/widgets/icon_disciplina.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import 'adicionar_disciplina_page.dart';

class DisciplinasPage extends StatefulWidget {
  ////StatefulWidget - Um Widget mutável
  final PageController? pc;

  const DisciplinasPage({Key? key, this.pc}) : super(key: key);

  @override
  State<DisciplinasPage> createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  adicionarDisciplina() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdicionarDisciplinaPage(),
      ),
    );
  }

  editarDisciplina(Disciplina disciplina) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditarDisciplinaPage(disciplina: disciplina),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Método build cria o widget em si
    return Scaffold(
      //Scaffold serve para formatar nossa tela em um MaterialApp
      appBar: AppBar(
        title: Text(S.of(context).Disciplinas),
      ),
      body: Consumer<DisciplinaRepository>(
          builder: (context, disciplinas, child) {
        return disciplinas.lista.isEmpty
            ? ListTile(
                leading: Icon(Icons.book),
                title: Text(S.of(context).NaoHaDisciplinas))
            : ListView.separated(
                //Corpo do App - Neste caso, uma ListView
                itemBuilder: (BuildContext context, int disciplina) {
                  return ListTile(
                      //Método para alinhar e formatar componentes em uma linha da lista
                      shape: RoundedRectangleBorder(
                        //Ajusta os componentes da lista para um formato circular
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      onTap: (() {
                        Provider.of<TarefaRepository>(context, listen: false)
                            .setFilter(disciplinas.lista[disciplina].cod);
                        widget.pc?.animateToPage(
                          2,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease,
                        );
                      }),
                      leading: IconDisciplina(
                          disciplina: disciplinas.lista[disciplina]),
                      title: Row(
                        children: [
                          Flexible(
                            child: Text(
                              disciplinas.lista[disciplina].nome,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                //Título do componente
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_horiz),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.edit, color: Colors.blue),
                              title: Text(S.of(context).Editar),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                              onTap: () {
                                Navigator.pop(context);
                                editarDisciplina(disciplinas.lista[disciplina]);
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.highlight_remove_outlined,
                                  color: Colors.red),
                              title: Text(S.of(context).Remover),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                              onTap: () {
                                disciplinas
                                    .remove(disciplinas.lista[disciplina]);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ));
                },
                padding: const EdgeInsets.all(
                    16), //Espaçamento em todas as laterais de um componente da lista
                separatorBuilder: (_, __) =>
                    Divider(), //Separa os componentes da lista com linhas
                itemCount: disciplinas.lista
                    .length, //Tamanho da lista que será renderizada (Informação necessária para o Flutter)
              );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: (() => adicionarDisciplina()),
          elevation: 5,
          backgroundColor: Colors.deepOrange[400],
          child: Icon(
            Icons.add,
            size: 30,
          )),
      //),
    );
  }
}
