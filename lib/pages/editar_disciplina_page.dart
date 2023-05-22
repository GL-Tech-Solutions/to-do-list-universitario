import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../models/disciplina.dart';
import '../repositories/disciplina_repository.dart';

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
            title: Text('Escolha a cor'),
            content: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildColorPicker(),
                  TextButton(
                    child: Flexible(
                      child: Text(
                        S.of(context).Selecionar,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ));

  void salvar() async {
    if (_form.currentState!.validate()) {
      widget.disciplina.nome = _nome.text;
      widget.disciplina.professor = _professor.text;
      widget.disciplina.cor = color;
      await Provider.of<DisciplinaRepository>(context, listen: false)
          .updateDisciplina(widget.disciplina);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            labelText: S.of(context).Nome),
                        validator: (value) {
                          // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                          if (value == null || value.isEmpty) {
                            return S.of(context).InformeNome;
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
                              labelText: S.of(context).Professor),
                          validator: (value) {
                            // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                            if (value == null || value.isEmpty) {
                              return S.of(context).InformeProf;
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
                          child: Text(
                            S.of(context).EscolherCor,
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
                            S.of(context).Salvar,
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
