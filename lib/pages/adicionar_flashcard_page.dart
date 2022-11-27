import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/flashcard.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../repositories/flashcard_repository.dart';

class AdicionarFlashcardPage extends StatefulWidget {
  const AdicionarFlashcardPage({super.key});
  @override
  State<AdicionarFlashcardPage> createState() => _AdicionarFlashCardPageState();
}

class _AdicionarFlashCardPageState extends State<AdicionarFlashcardPage> {
  final _form = GlobalKey<FormState>();
  final _question = TextEditingController();
  final _answer = TextEditingController();

  void salvar()
  {
    if (_form.currentState!.validate()) {
      Flashcard flashcard = Flashcard(question: _question.text, answer: _answer.text);
      List<Flashcard> lista = [];
      lista.add(flashcard);
      Provider.of<FlashcardRepository>(context, listen: false).saveAll(lista);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        validator: (value) { // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                          if (value == null || value.isEmpty) {
                            return 'Insira uma pergunta!';
                          }
                          return null;
                        },
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
                          validator: (value) { // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                          if (value == null || value.isEmpty) {
                            return 'Insira uma respota!';
                          }
                          return null;
                        },
                        ),
                      ),
                    ],
                  ),
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
    );
  }
}