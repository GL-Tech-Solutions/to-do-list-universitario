import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';
import 'package:flutter_aula_1/widgets/icon_disciplina.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class TarefasDetalhesDialog extends StatefulWidget {
  Tarefa tarefa;

  TarefasDetalhesDialog({Key? key, required this.tarefa}) : super(key: key);

  @override
  State<TarefasDetalhesDialog> createState() => _TarefasDetalhesDialogState();
}

class _TarefasDetalhesDialogState extends State<TarefasDetalhesDialog> {
  late DisciplinaRepository drepository;
  late ValueNotifier<int> porcentagem;

  @override
  void initState() {
    super.initState();
    porcentagem = ValueNotifier(widget.tarefa.porcentagemConclusao);
  }

  @override
  void dispose() {
    porcentagem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    drepository = context.read<DisciplinaRepository>();

    return AlertDialog(
      elevation: 20,
      icon: IconDisciplina(
        disciplina: drepository.lista.firstWhere(
            (element) => element.cod == widget.tarefa.codDisciplina),
      ),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.tarefa.nome,
                  style: TextStyle(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                widget.tarefa.status == 'Aberto'
                    ? AppLocalizations.of(context)!.pendentes
                    : AppLocalizations.of(context)!.concluidas,
                style: TextStyle(
                  color: widget.tarefa.status == 'Aberto'
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                widget.tarefa.tipo == 'Atividade'
                    ? AppLocalizations.of(context)!.atividade
                    : widget.tarefa.tipo == 'Trabalho'
                        ? AppLocalizations.of(context)!.trabalho
                        : widget.tarefa.tipo == 'Prova'
                            ? AppLocalizations.of(context)!.prova
                            : widget.tarefa.tipo == 'Reunião'
                                ? AppLocalizations.of(context)!.reuniao
                                : AppLocalizations.of(context)!.outros,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.dataFinal.toUpperCase()}: ',
                          style: TextStyle(
                              color: Colors.purple[800],
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      TextSpan(
                        text:
                            DateFormat('dd/MM/yyyy').format(widget.tarefa.data),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.descricao.toUpperCase()}: ',
                            style: TextStyle(
                                color: Colors.purple[800],
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        TextSpan(
                          text: widget.tarefa.descricao == ''
                              ? AppLocalizations.of(context)!.naoHaDescricao
                              : widget.tarefa.descricao,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: widget.tarefa.status != 'Finalizado',
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Text(
                          'Conclusão',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: porcentagem,
                    builder: (BuildContext context, int porcentagemValue,
                        Widget? child) {
                      return Visibility(
                        child: Row(
                          children: [
                            Expanded(
                              child: Theme(
                                data: ThemeData(
                                  sliderTheme: SliderThemeData(
                                    showValueIndicator:
                                        ShowValueIndicator.never,
                                  ),
                                ),
                                child: Slider(
                                  value: porcentagemValue.toDouble(),
                                  onChanged: (value) =>
                                      porcentagem.value = value.toInt(),
                                  activeColor: Colors.orange,
                                  max: 100,
                                  divisions: 10,
                                  label: '',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              ' ${porcentagemValue.toString()}%',
                              style: TextStyle(
                                fontSize: 16,
                                color: porcentagemValue <= 30
                                    ? Colors.redAccent
                                    : porcentagemValue <= 60
                                        ? Colors.orange
                                        : porcentagemValue < 90
                                            ? Colors.yellow
                                            : Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      actions: [
        ValueListenableBuilder(
          valueListenable: porcentagem,
          builder: (BuildContext context, int porcentagemValue, Widget? child) {
            return Visibility(
              visible: porcentagemValue != widget.tarefa.porcentagemConclusao &&
                  widget.tarefa.status != 'Finalizado',
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final Tarefa updatedTarefa = widget.tarefa.copyWith(
                          porcentagemConclusao: porcentagem.value,
                          status: porcentagem.value == 100
                              ? 'Finalizado'
                              : 'Aberto',
                        );
                        await context
                            .read<TarefaRepository>()
                            .updateTarefa(updatedTarefa);
                        navigator.pop();
                      },
                      child: Text(AppLocalizations.of(context)!.salvar),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
