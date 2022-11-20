import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../models/disciplina.dart';

// ignore: must_be_immutable
class EditarDisciplinaPage extends StatefulWidget {
  Disciplina disciplina;

  EditarDisciplinaPage({super.key, required this.disciplina});

  @override
  State<EditarDisciplinaPage> createState() => _EditarDisciplinaPageState();
}

class _EditarDisciplinaPageState extends State<EditarDisciplinaPage> {
  final _form = GlobalKey<FormState>(); // Gera uma key (identificador) para o formulário
  late Color color;

  @override
  void initState() {
    super.initState();
    color = widget.disciplina.cor;
  }

  Widget buildColorPicker() => ColorPicker(
    pickerColor: color,
   
    onColorChanged: (color) => setState(() => this.color = color),
 );

 void pickColor(BuildContext context) => showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text('Escolha a cor para a disciplina'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildColorPicker(),
        TextButton(
          child: Text(
            'SELECIONAR',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar disciplina'
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
                        initialValue: widget.disciplina.nome,
                        controller: null,
                        style: TextStyle(
                          fontSize: 18
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          labelText: 'Nome'
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: TextFormField(
                          maxLines: null,
                          initialValue: widget.disciplina.professor,
                          controller: null,
                          style: TextStyle(
                            fontSize: 18
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16))
                            ),
                            labelText: 'Professor'
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
                        child: Text('Escolher cor',
                        style: TextStyle(fontSize: 14),
                        ),
                        onPressed: () => pickColor(context),
                       ),
                      ],
                     ),
                    ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple[800]
                  ),
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: null,
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
    );
  }
}