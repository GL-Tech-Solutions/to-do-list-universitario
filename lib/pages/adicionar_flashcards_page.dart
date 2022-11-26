import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../repositories/disciplina_repository.dart';

class AdicionarFlashcardsPage extends StatefulWidget {
  const AdicionarFlashcardsPage({super.key});
  @override
  State<AdicionarFlashcardsPage> createState() => _AdicionarFlashCardsPageState();
}

class _AdicionarFlashCardsPageState extends State<AdicionarFlashcardsPage> {
  final _form = GlobalKey<FormState>();
  final _question = TextEditingController();
  final _answer = TextEditingController();
  String? _disciplina;
  late DisciplinaRepository drepository;

  void dropdownCallbackDisciplina(String? value)
  {
    setState(() {
      _disciplina = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    drepository = context.read<DisciplinaRepository>();

    return MaterialApp(
      localizationsDelegates: [S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                        controller: _question,
                        style: TextStyle(
                          fontSize: 18
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          labelText: S.of(context).Pergunta
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: TextFormField(
                          maxLines: null,
                          controller: _answer,
                          style: TextStyle(
                            fontSize: 18
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16))
                            ),
                            labelText: S.of(context).Resposta
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
                    ],
                  ),
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
                          S.of(context).Salvar,
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
    ),
    );
  }
}