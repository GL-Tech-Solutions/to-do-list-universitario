import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_aula_1/widgets/icon_disciplina.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';

class TarefasDetalhesDialog extends StatelessWidget {
  Tarefa tarefa;

  TarefasDetalhesDialog({Key? key, required this.tarefa}) : super(key: key);

  late DisciplinaRepository drepository;

  @override
  Widget build(BuildContext context) {
    drepository = context.read<DisciplinaRepository>();

    return AlertDialog(
      icon: IconDisciplina(disciplina: drepository.lista.firstWhere((element) => element.cod == tarefa.codDisciplina)),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  tarefa.nome,
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                tarefa.status == 'Aberto' ? 'PENDENTE' : 'FINALIZADO',
                style: TextStyle(
                  color: tarefa.status == 'Aberto' ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
                )
              )
            ] 
          ),
          Row(
            children: [
              Text(
                tarefa.tipo,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: 13
                ),
              )
            ]
          )
        ]
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: 'DATA FINAL: ', style: TextStyle(color: Colors.purple[800], fontWeight: FontWeight.w600, fontSize: 15)),
                    TextSpan(text: DateFormat('dd/MM/yyyy').format(tarefa.data), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15))
                  ]
                )
              ),
            ]
          ),
          Row(
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'DESCRIÇÃO: ', style: TextStyle(color: Colors.purple[800], fontWeight: FontWeight.w600, fontSize: 15)),
                      TextSpan(text: tarefa.descricao == '' ? 'Sem descrição' : tarefa.descricao, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15))
                    ]
                  )
                ),
              ),
            ]
          ),
        ]
      ),
      elevation: 20,
    );
  }
}