import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../models/disciplina.dart';

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
                            value: op.nome,
                            child: Text(op.nome, overflow: TextOverflow.ellipsis),
                          )).toList(),
                          value: _disciplina,
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
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [maskDateFormatter],
                          maxLines: null,
                          controller: _data,
                          style: TextStyle(fontSize: 18),
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
                                  setState(() => _data.text = DateFormat('dd/MM/yyyy').format(DateTime(newDate.year, newDate.month, newDate.day)));
                                }
                              }, 
                              icon: Icon(Icons.calendar_month)
                            )
                          ),
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
                  decoration: BoxDecoration(
                    color: Colors.purple[800]
                  ),
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    style: ButtonStyle(
                    ),
                    onPressed: null,
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