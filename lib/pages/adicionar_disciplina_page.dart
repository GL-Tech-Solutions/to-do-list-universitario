import 'dart:math';
import 'dart:ui';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter/material.dart';

class AdicionarDisciplinaPage extends StatefulWidget {
  const AdicionarDisciplinaPage({super.key});
  @override
  State<AdicionarDisciplinaPage> createState() => _AdicionarDisciplinaPageState();
}


class _AdicionarDisciplinaPageState extends State<AdicionarDisciplinaPage> {
  final _form = GlobalKey<FormState>(); // Gera uma key (identificador) para o formulário
  final _nome = TextEditingController();
  final _professor = TextEditingController();
  Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];


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
                        controller: _nome,
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
                          controller: _professor,
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
                  children: [
                Padding(padding: EdgeInsets.only(top:14),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(  
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric()),     
                        child: Text('Escolher cor',
                        style: TextStyle(fontSize: 14),
                        ),
                        onPressed: () => pickColor(context),
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

 Widget buildColorPicker() => ColorPicker(
    pickerColor: color,
    enableAlpha: false,
    showLabel: false,
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
}