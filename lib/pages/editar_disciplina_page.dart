import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  final _form = GlobalKey<FormState>(); // Gera uma key (identificador) para o formulário
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
      title: Text(S.of(context).EscolhaACorParaADisciplina),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildColorPicker(),
        TextButton(
          child: Text(
            S.of(context).Selecionar,
        style: TextStyle(
          fontSize: 14,
        ),
        ),
        onPressed: () => Navigator.of(context).pop(),
          ),
         ],
      ),
    )
 );

 void salvar()
  {
    widget.disciplina.nome = _nome.text;
    widget.disciplina.professor = _professor.text;
    widget.disciplina.cor = color;
    List<Disciplina> lista = [];
    lista.add(widget.disciplina);
    Provider.of<DisciplinaRepository>(context, listen: false).saveAll(lista);
  }

  @override
  Widget build(BuildContext context) {
    return /*MaterialApp(
      localizationsDelegates: [ S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      home: */Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Adicionar
        ),
      ),
      body: Center(
        child: 
        Padding(
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
                        style: TextStyle(
                          fontSize: 18
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          labelText: S.of(context).Nome
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: TextFormField(
                          maxLines: null,
                          controller: _professor,
                          style: TextStyle(
                            fontSize: 18
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16))
                            ),
                            labelText: S.of(context).Professor
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column( children: [
                Padding(padding: EdgeInsets.only(top:14, right: 150),
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
                      Column( children: [  
                      const SizedBox(height: 32),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center
                          ),     
                        child: Text(S.of(context).EscolherCor,
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
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[800])),
                    onPressed: (() {
                      salvar();
                      Navigator.pop(context);
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.all(16),
                        child: Text(
                          'SALVAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
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
      //),
    );
  }
}