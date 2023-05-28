import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/disciplina.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdicionarDisciplinaPage extends StatefulWidget {
  const AdicionarDisciplinaPage({super.key});
  @override
  State<AdicionarDisciplinaPage> createState() =>
      _AdicionarDisciplinaPageState();
}

class _AdicionarDisciplinaPageState extends State<AdicionarDisciplinaPage> {
  final _form =
      GlobalKey<FormState>(); // Gera uma key (identificador) para o formulário
  final _nome = TextEditingController();
  final _professor = TextEditingController();
  Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  void salvar() async {
    if (_form.currentState!.validate()) {
      Disciplina disciplina =
          Disciplina(cor: color, nome: _nome.text, professor: _professor.text);
      await Provider.of<DisciplinaRepository>(context, listen: false)
          .saveDisciplina(disciplina);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.adicionar),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        child: TextFormField(
                          maxLines: null,
                          controller: _professor,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              labelText:
                                  AppLocalizations.of(context)!.professor),
                          validator: (value) {
                            // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.informeProf;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 14, right: 150),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                            ),
                            width: 50,
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 32),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center),
                          child: AutoSizeText(
                            AppLocalizations.of(context)!.escolherCor,
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: () => pickColor(context),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple[800])),
                    onPressed: salvar,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            AppLocalizations.of(context)!.salvar,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildColorPicker() => ColorPicker(
        pickerColor: color,
        onColorChanged: (color) => setState(() => this.color = color),
      );

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.escolherCor),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildColorPicker(),
                TextButton(
                  child: Text(
                    AppLocalizations.of(context)!.selecionar,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ));
}
