import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../pages/editar_tarefa_page.dart';
import 'tarefas_detalhes_dialog.dart';
import '../repositories/disciplina_repository.dart';
import '../repositories/selecionadas_repository.dart';
import '../repositories/tarefa_respository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class TarefaCard extends StatefulWidget {
  Tarefa tarefa;

  TarefaCard({super.key, required this.tarefa});

  @override
  State<TarefaCard> createState() => _TarefaCardState();
}

class _TarefaCardState extends State<TarefaCard> {
  late DisciplinaRepository drepository;
  late Selecionadas se;
  late TarefaRepository trepository;

  void mostrarDetalhes(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => TarefasDetalhesDialog(tarefa: widget.tarefa));
  }

  void editarTarefa(Tarefa tarefa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditarTarefaPage(tarefa: tarefa),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    se = context.watch<Selecionadas>();
    drepository = context.watch<DisciplinaRepository>();
    trepository = context.watch<TarefaRepository>();

    return Card(
      margin: EdgeInsets.only(top: 8),
      elevation: 2,
      child: InkWell(
        onTap: () {
          //Clicando em uma disciplina quando na lista de seleção, ela é selecionada. Porém se ela já está selecionada, ela é removida
          setState(() {
            //Altera o estado do widget, permitindo um rebuild
            if (se.selecionadas.isEmpty) {
              mostrarDetalhes(context);
            } else if (se.selecionadas.isNotEmpty &&
                !se.selecionadas.contains(widget.tarefa)) {
              Provider.of<Selecionadas>(context, listen: false)
                  .adicionarSelecionada(widget.tarefa);
            } else if (se.selecionadas.contains(widget.tarefa)) {
              Provider.of<Selecionadas>(context, listen: false)
                  .limparSelecionada(widget.tarefa);
            }
          });
        },
        onLongPress: () {
          //Pressionando em uma disciplina, ativa a lista de seleção e adiciona a disciplina pressionada na mesma
          Provider.of<Selecionadas>(context, listen: false)
              .iniciarSelecionadas(widget.tarefa);
        },
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
          decoration: BoxDecoration(
            color: (se.selecionadas.contains(widget.tarefa))
                ? Colors.indigoAccent.withOpacity(0.3)
                : null,
            border: (se.selecionadas.contains(widget.tarefa))
                ? Border(
                    top: BorderSide(
                        color: drepository.lista
                            .firstWhere((element) =>
                                element.cod == widget.tarefa.codDisciplina)
                            .cor, //Pega a cor selecionada da disciplina e a coloca na borda superior
                        width: 5),
                    left: BorderSide(
                      color: drepository.lista
                          .firstWhere((element) =>
                              element.cod == widget.tarefa.codDisciplina)
                          .cor,
                      width: 2,
                    ),
                    right: BorderSide(
                      color: drepository.lista
                          .firstWhere((element) =>
                              element.cod == widget.tarefa.codDisciplina)
                          .cor,
                      width: 2,
                    ),
                    bottom: BorderSide(
                      color: drepository.lista
                          .firstWhere((element) =>
                              element.cod == widget.tarefa.codDisciplina)
                          .cor,
                      width: 2,
                    ))
                : Border(
                    top: BorderSide(
                        color: drepository.lista
                            .firstWhere((element) =>
                                element.cod == widget.tarefa.codDisciplina)
                            .cor, //Pega a cor selecionada da disciplina e a coloca na borda superior
                        width: 5),
                  ),
          ),
          child: Row(
            children: [
              (se.selecionadas.isEmpty)
                  ? IconButton(
                      iconSize: 30,
                      icon: (widget.tarefa.status == 'Aberto')
                          ? Icon(Icons.circle_outlined)
                          : Icon(Icons.check_circle, color: Colors.green),
                      onPressed: () {
                        List<Tarefa> pressionadas = [];
                        pressionadas.add(widget.tarefa);
                        Provider.of<TarefaRepository>(context, listen: false)
                            .setStatus(pressionadas);
                      })
                  : (se.selecionadas.contains(widget.tarefa))
                      ? IconButton(
                          icon: Icon(Icons.check_box_outlined,
                              color: Colors.black),
                          iconSize: 30,
                          onPressed: null)
                      : IconButton(
                          icon:
                              Icon(Icons.square_outlined, color: Colors.black),
                          iconSize: 30,
                          onPressed: null),
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
                              widget.tarefa.nome,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  decoration:
                                      (widget.tarefa.status == 'Finalizado')
                                          ? TextDecoration.lineThrough
                                          : null),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              ' ${widget.tarefa.porcentagemConclusao.toString()}%',
                              style: TextStyle(
                                fontSize: 16,
                                color: widget.tarefa.porcentagemConclusao <= 30
                                    ? Colors.redAccent
                                    : widget.tarefa.porcentagemConclusao <= 60
                                        ? Colors.orange
                                        : widget.tarefa.porcentagemConclusao <
                                                90
                                            ? Colors.yellow
                                            : Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                                decoration:
                                    (widget.tarefa.status == 'Finalizado')
                                        ? TextDecoration.lineThrough
                                        : null,
                              ),
                            ),
                          ),
                          /*(widget.tarefa.visibilidade ?? false)
                              ? Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.2),
                                      border: Border.all(
                                          color: Colors.green, width: 1),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                    AppLocalizations.of(context)!.publico,
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.2),
                                    border:
                                        Border.all(color: Colors.red, width: 1),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.privado,
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                )*/
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.tarefa.tipo == 'Atividade'
                                ? AppLocalizations.of(context)!.atividade
                                : widget.tarefa.tipo == 'Trabalho'
                                    ? AppLocalizations.of(context)!.trabalho
                                    : widget.tarefa.tipo == 'Prova'
                                        ? AppLocalizations.of(context)!.prova
                                        : widget.tarefa.tipo == 'Reunião'
                                            ? AppLocalizations.of(context)!
                                                .reuniao
                                            : AppLocalizations.of(context)!
                                                .outros,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.date_range,
                                  size: 15, color: Colors.black54),
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(widget.tarefa.data),
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
                icon: (se.selecionadas.isEmpty)
                    ? Icon(Icons.more_vert)
                    : Icon(Icons.more_vert, size: 0),
                enabled: (se.selecionadas.isEmpty) ? true : false,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.edit, color: Colors.blue),
                      title: Text(AppLocalizations.of(context)!.editar),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      onTap: () {
                        Navigator.pop(context);
                        editarTarefa(widget.tarefa);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.highlight_remove_outlined,
                          color: Colors.red),
                      title: Text(AppLocalizations.of(context)!.remover),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      onTap: () {
                        List<Tarefa> removidas = [];
                        removidas.add(widget.tarefa);
                        Provider.of<TarefaRepository>(context, listen: false)
                            .remove(removidas);
                        Navigator.pop(context);
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
  }
}
