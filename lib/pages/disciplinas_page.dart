import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/disciplina.dart';
import 'package:flutter_aula_1/pages/editar_disciplina_page.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';

import 'adicionar_disciplina_page.dart';

class DisciplinasPage extends StatefulWidget { ////StatefulWidget - Um Widget mutável

  const DisciplinasPage({Key? key}) : super(key: key);

  @override
  State<DisciplinasPage> createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  final tabela = DisciplinaRepository.tabela; //Pega a tabela de disciplinas e coloca nesta variável lista

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
  Widget build(BuildContext context) { //Método build cria o widget em si
    return Scaffold( //Scaffold serve para formatar nossa tela em um MaterialApp
      appBar: AppBar(
        title: Text('Disciplinas'),
      ),
      body: ListView.separated( //Corpo do App - Neste caso, uma ListView
        itemBuilder: (BuildContext context, int disciplina) {
          return ListTile( //Método para alinhar e formatar componentes em uma linha da lista
            shape: RoundedRectangleBorder( //Ajusta os componentes da lista para um formato circular
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            leading: CircleAvatar(
                  backgroundColor: tabela[disciplina].cor,
                  child: Text(
                    getInitials(tabela[disciplina].nome),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            title: Row(
              children: [
                Flexible(
                  child: Text(
                    tabela[disciplina].nome,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle( //Título do componente
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
                    title: Text('Editar Disciplina'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    onTap: () {
                      Navigator.pop(context);
                      editarDisciplina(tabela[disciplina]);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.highlight_remove_outlined, color: Colors.red),
                    title: Text('Remover Disciplina'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          );
        }, 
        padding: const EdgeInsets.all(16), //Espaçamento em todas as laterais de um componente da lista
        separatorBuilder: (_, __) => Divider(),  //Separa os componentes da lista com linhas
        itemCount: tabela.length, //Tamanho da lista que será renderizada (Informação necessária para o Flutter)
        ),
         floatingActionButton: FloatingActionButton(
            onPressed: (() => adicionarDisciplina()),
            elevation: 5,
            backgroundColor: Colors.deepOrange[400],
            child: Icon(Icons.add, size: 30,)
         ),
    );
  }
}