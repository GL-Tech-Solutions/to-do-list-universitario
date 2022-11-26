import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../models/disciplina.dart';
import '../models/tarefa.dart';

class AdiconarTarefaPage extends StatefulWidget {
  const AdiconarTarefaPage({super.key});

  @override
  State<AdiconarTarefaPage> createState() => _AdiconarTarefaPageState();
}

class _AdiconarTarefaPageState extends State<AdiconarTarefaPage> {
  final _form = GlobalKey<FormState>(); // Gera uma key (identificador) para o formulário
  final _nome = TextEditingController(); // Permite editar o texto valor e controlá-lo
  String? _tipo;
  String? _disciplina;
  var _data = TextEditingController();
  final _descricao = TextEditingController();
  bool _visibilidade = false;
  late DisciplinaRepository drepository;
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final maskDateFormatter = MaskTextInputFormatter(
    mask: 'xx/xx/xxxx',
    filter: {'x': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy
  );

  void dropdownCallbackTipo(String? value)
  {
    setState(() {
      _tipo = value;
    });
  }

  void dropdownCallbackDisciplina(String? value)
  {
    setState(() {
      _disciplina = value;
    });
  }

  void alterarVisibilidade () {
    setState(() {
      (_visibilidade) ? _visibilidade = false : _visibilidade = true;
    });
  }

  void salvar()
  {
    if (_form.currentState!.validate()) {
      Tarefa tarefa = Tarefa(
      nome: _nome.text,
      descricao: _descricao.text,
      codDisciplina: _disciplina!,
      tipo: _tipo!,
      data: DateTime(int.parse(_data.text.substring(6,10)), int.parse(_data.text.substring(3,5)), int.parse(_data.text.substring(0,2))),
      status: 'Aberto',
      visibilidade: _visibilidade
      );
      List<Tarefa> lista = [];
      lista.add(tarefa);
      Provider.of<TarefaRepository>(context, listen: false).saveAll(lista);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    drepository = context.read<DisciplinaRepository>();

    return /*MaterialApp(
      localizationsDelegates: [S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      home: */Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Adicionar),
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
                            borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          labelText: S.of(context).Nome
                        ),
                        validator: (value) { // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                          if (value == null || value.isEmpty) {
                            return S.of(context).InformeNome;
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: DropdownButtonFormField(
                          items: [
                            DropdownMenuItem(value: 'Atividade', child: Text(S.of(context).Atividade)),
                            DropdownMenuItem(value: 'Trabalho', child: Text(S.of(context).Trabalho)),
                            DropdownMenuItem(value: 'Prova', child: Text(S.of(context).Prova)),
                            DropdownMenuItem(value: 'Reunião', child: Text(S.of(context).Reuniao)),
                            DropdownMenuItem(value: 'Outros', child: Text(S.of(context).Outros)),
                          ],
                          value: _tipo,
                          onChanged: dropdownCallbackTipo,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          validator: (value) { // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                            if (value == null) {
                              return S.of(context).InformeTipo;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16))
                            ),
                            labelText: S.of(context).Tipo
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          items: drepository.lista.map((op) => DropdownMenuItem(
                            value: op.cod,
                            child: Text(op.nome, overflow: TextOverflow.ellipsis),
                          )).toList(),
                          value: _disciplina,
                          validator: (value) {
                            if (value == null) {
                              return ;
                            }
                            return null;
                          },
                          onChanged: dropdownCallbackDisciplina,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16))
                            ),
                            labelText: S.of(context).Disciplina
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [maskDateFormatter],
                                maxLines: null,
                                controller: _data,
                                style: TextStyle(fontSize: 18),
                                validator: (value) { // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                                  if (value == null || value.isEmpty || value.length < 10) {
                                    return S.of(context).DataValida;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16))
                                  ),
                                  labelText: S.of(context).DataFinal,
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate: date,
                                        firstDate: DateTime(DateTime.now().year),
                                        lastDate: DateTime(2030),
                                      );
                                      if (newDate != null) {
                                        setState(() {
                                          _data.text = DateFormat('dd/MM/yyyy').format(DateTime(newDate.year, newDate.month, newDate.day));
                                        });
                                      }
                                    }, 
                                    icon: Icon(Icons.calendar_month)
                                  )
                                ),
                              ),
                            ),
                           
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(
                                  (_visibilidade) ? 'PÚBLICO' : 'PRIVADO',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: (_visibilidade) ? Colors.green : Colors.red),
                                ),
                                Switch(value: _visibilidade,onChanged: (value) => alterarVisibilidade())
                                ],
                              ),
                            )
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
                              borderRadius: BorderRadius.all(Radius.circular(16))
                            ),
                            labelText: S.of(context).Descricao,
                            alignLabelWithHint: true
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[800])),
                    onPressed: (() {
                      salvar();
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            S.of(context).Salvar,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white
                            ),
                          )
                        )
                      ],
                    )
                  ),
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