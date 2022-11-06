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
  late Map<String, String> loc;
  List<Disciplina> selecionadas = []; //Lista de disciplinas selecionadas

  AppBar appBarDinamica()
  {
    if(selecionadas.isEmpty) //Se lista de selecionadas estiver vazia, fica na AppBar padrão
    {
      return AppBar( //Barra do App
        title: const Text('Disciplinas'), //Título App
        /*actions: [
          changeLanguageButton(),
        ],*/
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

  void limparSelecionadas()
  {
    setState(() {
      selecionadas = [];
    });
  }

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
            leading: (selecionadas.contains(tabela[disciplina])) //Define um ícone da lista (lado esquerdo)
              ? CircleAvatar(
                  child: Icon(Icons.check), //Define um ícone de "Check"
                )
              : CircleAvatar(
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
            selected: selecionadas.contains(tabela[disciplina]),
            selectedTileColor: Colors.indigo[50],
            onTap: () { //Clicando em uma disciplina quando na lista de seleção, ela é selecionada. Porém se ela já está selecionada, ela é removida
              setState(() { //Altera o estado do widget, permitindo um rebuild
              if (selecionadas.isEmpty)
              {
                //mostrarDetalhes(tabela[disciplina]);
              }
              else if (selecionadas.isNotEmpty && !selecionadas.contains(tabela[disciplina]))
              {
                selecionadas.add(tabela[disciplina]);
              }
              else if (selecionadas.contains(tabela[disciplina]))
                {
                  selecionadas.remove(tabela[disciplina]);
                }
              });
            },
            onLongPress: () { //Pressionando em uma disciplina, ativa a lista de seleção e adiciona a disciplina pressionada na mesma
              setState(() {
                if (selecionadas.isEmpty)
                {
                  selecionadas.add(tabela[disciplina]);
                }
              });
            },

          );
        }, 
        padding: const EdgeInsets.all(16), //Espaçamento em todas as laterais de um componente da lista
        separatorBuilder: (_, __) => Divider(),  //Separa os componentes da lista com linhas
        itemCount: tabela.length, //Tamanho da lista que será renderizada (Informação necessária para o Flutter)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //Define a posição do FAB no centro
        /*floatingActionButton: selecionadas.isNotEmpty //Verifica se está na tela de selecionadas
          ? FloatingActionButton.extended(
            onPressed: () {
              favoritas.saveAll(selecionadas);
              limparSelecionadas();
            },
            icon: Icon(Icons.star),
            label: Text(
              'FAVORITAR',
              style: TextStyle(
                letterSpacing: 0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
         : null,*/
    );
  }
}