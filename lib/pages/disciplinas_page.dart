import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_aula_1/configs/app_setting.dart';
import 'package:flutter_aula_1/models/disciplina.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:provider/provider.dart';

class DisciplinasPage extends StatefulWidget { ////StatefulWidget - Um Widget mutável

  const DisciplinasPage({Key? key}) : super(key: key);

  @override
  State<DisciplinasPage> createState() => _DisciplinasPageState();
}

class _DisciplinasPageState extends State<DisciplinasPage> {
  final tabela = DisciplinaRepository.tabela; //Pega a tabela de disciplinas e coloca nesta variável lista

  /**
   * Método que fará a rota para a page "DisciplinasDetalhesPage"
   */
  /*void mostrarDetalhes(Disciplina disciplina)
  {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => DisciplinasDetalhesPage(disciplina: disciplina)
      ),
    );
  }*/

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
          );
        }, 
        padding: const EdgeInsets.all(16), //Espaçamento em todas as laterais de um componente da lista
        separatorBuilder: (_, __) => Divider(),  //Separa os componentes da lista com linhas
        itemCount: tabela.length, //Tamanho da lista que será renderizada (Informação necessária para o Flutter)
        ),
    );
  }
}