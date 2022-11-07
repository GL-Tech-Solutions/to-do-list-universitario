import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';

class TarefaCard extends StatefulWidget {
  Tarefa tarefa;

  TarefaCard({Key? key, required this.tarefa}) : super(key: key);

  @override
  _TarefaCardState createState() => _TarefaCardState();
}

class _TarefaCardState extends State<TarefaCard> {

  /*abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TarefasDetalhesPage(tarefa: widget.tarefa),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 8),
      elevation: 2,
      child: InkWell(
        //onTap: () => abrirDetalhes(),
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
          decoration: BoxDecoration(
            border: Border(
              top:  BorderSide(
                color: DisciplinaRepository.tabela[widget.tarefa.codDisciplina].cor, //Pega a cor selecionada da disciplina e a coloca na borda superior
                width: 5
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.circle_outlined,
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
                              widget.tarefa.nome,
                              style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          widget.tarefa.visibilidade
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
                            widget.tarefa.tipo,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(widget.tarefa.data),
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
              /*Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: precoColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: precoColor['down']!.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  real.format(widget.tarefa.preco),
                  style: TextStyle(
                    fontSize: 16,
                    color: precoColor['down'],
                    letterSpacing: -1,
                  ),
                ),
              ),*/
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: Text('Remover Tarefa'),
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<ListarTarefas>(context, listen: false)
                            .remove(widget.tarefa);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}