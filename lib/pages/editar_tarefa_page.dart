import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../repositories/disciplina_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class EditarTarefaPage extends StatefulWidget {
  Tarefa tarefa;

  EditarTarefaPage({super.key, required this.tarefa});

  @override
  State<EditarTarefaPage> createState() => _EditarTarefaPageState();
}

class _EditarTarefaPageState extends State<EditarTarefaPage> {
  final _form =
      GlobalKey<FormState>(); // Gera uma key (identificador) para o formulário
  final _nome =
      TextEditingController(); // Permite editar o texto valor e controlá-lo
  String? _tipo;
  String? _disciplina;
  String? disciplinaInicial;
  final _data = TextEditingController();
  final _descricao = TextEditingController();
  bool _visibilidade = false;
  late DisciplinaRepository drepository;
  late Tarefa tInicial;
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final maskDateFormatter = MaskTextInputFormatter(
      mask: 'xx/xx/xxxx',
      filter: {'x': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    _nome.text = widget.tarefa.nome;
    _tipo = widget.tarefa.tipo;
    _disciplina = widget.tarefa.codDisciplina;
    _data.text = DateFormat('dd/MM/yyyy').format(DateTime(
        widget.tarefa.data.year,
        widget.tarefa.data.month,
        widget.tarefa.data.day));
    _descricao.text = widget.tarefa.descricao!;
    _visibilidade = widget.tarefa.visibilidade ?? false;
    tInicial = widget.tarefa;
  }

  void dropdownCallbackTipo(String? value) {
    setState(() {
      _tipo = value;
    });
  }

  void dropdownCallbackDisciplina(String? value) {
    setState(() {
      _disciplina = value;
    });
  }

  void alterarVisibilidade() {
    setState(() {
      (_visibilidade) ? _visibilidade = false : _visibilidade = true;
    });
  }

  void salvar() async {
    if (_form.currentState!.validate()) {
      tInicial = tInicial.copyWith(
        nome: _nome.text,
        tipo: _tipo!,
        codDisciplina: _disciplina,
        data: DateTime(
          int.parse(_data.text.substring(6, 10)),
          int.parse(_data.text.substring(3, 5)),
          int.parse(_data.text.substring(0, 2)),
        ),
        descricao: _descricao.text,
        visibilidade: _visibilidade,
      );
      await Provider.of<TarefaRepository>(context, listen: false)
          .updateTarefa(tInicial);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    drepository = context.read<DisciplinaRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editar),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLines: null,
                          controller: _nome,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              labelText: AppLocalizations.of(context)!.nome),
                          validator: (value) {
                            // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.informeNome;
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: DropdownButtonFormField(
                            items: [
                              DropdownMenuItem(
                                  value: 'Atividade',
                                  child: Text(
                                      AppLocalizations.of(context)!.atividade)),
                              DropdownMenuItem(
                                  value: 'Trabalho',
                                  child: Text(
                                      AppLocalizations.of(context)!.trabalho)),
                              DropdownMenuItem(
                                  value: 'Prova',
                                  child: Text(
                                      AppLocalizations.of(context)!.prova)),
                              DropdownMenuItem(
                                  value: 'Reunião',
                                  child: Text(
                                      AppLocalizations.of(context)!.reuniao)),
                              DropdownMenuItem(
                                  value: 'Outros',
                                  child: Text(
                                      AppLocalizations.of(context)!.outros)),
                            ],
                            value: _tipo,
                            validator: (value) {
                              // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                              if (value == null) {
                                return AppLocalizations.of(context)!
                                    .informeTipo;
                              }
                              return null;
                            },
                            onChanged: dropdownCallbackTipo,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                labelText: AppLocalizations.of(context)!.tipo),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            items: drepository.lista
                                .map((op) => DropdownMenuItem(
                                      value: op.cod,
                                      child: Text(op.nome,
                                          overflow: TextOverflow.ellipsis),
                                    ))
                                .toList(),
                            value: _disciplina,
                            validator: (value) {
                              if (value == null) {
                                return AppLocalizations.of(context)!
                                    .informeDisciplina;
                              }
                              return null;
                            },
                            onChanged: dropdownCallbackDisciplina,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              labelText:
                                  AppLocalizations.of(context)!.disciplina,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [maskDateFormatter],
                                  maxLines: null,
                                  controller: _data,
                                  style: TextStyle(fontSize: 18),
                                  validator: (value) {
                                    // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 10) {
                                      return AppLocalizations.of(context)!
                                          .dataValida;
                                    } else if (DateTime(
                                      int.parse(value.substring(6, 10)),
                                      int.parse(value.substring(3, 5)),
                                      int.parse(value.substring(0, 2)),
                                    )
                                        .compareTo(DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day))
                                        .isNegative) {
                                      return AppLocalizations.of(context)!
                                          .dataValida;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      labelText: AppLocalizations.of(context)!
                                          .dataFinal,
                                      suffixIcon: IconButton(
                                          onPressed: () async {
                                            DateTime? newDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: date,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2030),
                                            );
                                            if (newDate != null) {
                                              setState(
                                                () {
                                                  _data.text =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(
                                                    DateTime(
                                                      newDate.year,
                                                      newDate.month,
                                                      newDate.day,
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          icon: Icon(Icons.calendar_month))),
                                ),
                              ),
                              /*const SizedBox(
                                 width: 10,
                              ),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AutoSizeText(
                                      (_visibilidade)
                                          ? AppLocalizations.of(context)!
                                              .publico
                                          : AppLocalizations.of(context)!
                                              .privado,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: (_visibilidade)
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                    Switch(
                                        value: _visibilidade,
                                        onChanged: (value) =>
                                            alterarVisibilidade())
                                  ],
                                ),
                              )*/
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: TextFormField(
                            maxLines: 5,
                            controller: _descricao,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                labelText:
                                    AppLocalizations.of(context)!.descricao,
                                alignLabelWithHint: true),
                          ),
                        ),
                      ],
                    )),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple[800])),
                      onPressed: () {
                        salvar();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                AppLocalizations.of(context)!.salvar,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ))
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      //),
    );
  }
}
