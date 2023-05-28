import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import '../models/disciplina.dart';
import '../repositories/disciplina_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class EditarDisciplinaPage extends StatefulWidget {
  Disciplina disciplina;

  EditarDisciplinaPage({super.key, required this.disciplina});

  @override
  State<EditarDisciplinaPage> createState() => _EditarDisciplinaPageState();
}

class _EditarDisciplinaPageState extends State<EditarDisciplinaPage> {
  final _form =
      GlobalKey<FormState>(); // Gera uma key (identificador) para o formulário
  final _nome = TextEditingController();
  final _professor = TextEditingController();
  late Color color;

  @override
  void initState() {
    super.initState();
    color = widget.disciplina.cor;
    _nome.text = widget.disciplina.nome;
    _professor.text = widget.disciplina.professor;
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
        ),
      );

  void salvar() async {
    if (_form.currentState!.validate()) {
      widget.disciplina.nome = _nome.text;
      widget.disciplina.professor = _professor.text;
      widget.disciplina.cor = color;
      await Provider.of<DisciplinaRepository>(context, listen: false)
          .updateDisciplina(widget.disciplina);
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
                    onPressed: (() {
                      salvar();
                    }),
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
}
