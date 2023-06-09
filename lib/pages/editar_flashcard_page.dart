import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/flashcard.dart';
import 'package:provider/provider.dart';
import '../repositories/flashcard_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditarFlashCardPage extends StatefulWidget {
  final Flashcard flashcard;

  const EditarFlashCardPage({super.key, required this.flashcard});

  @override
  State<EditarFlashCardPage> createState() => _EditarFlashCardPageState();
}

class _EditarFlashCardPageState extends State<EditarFlashCardPage> {
  final _form = GlobalKey<FormState>();
  final _question = TextEditingController();
  final _answer = TextEditingController();

  @override
  void initState() {
    super.initState();
    _question.text = widget.flashcard.question;
    _answer.text = widget.flashcard.answer;
  }

  void salvar() {
    if (_form.currentState!.validate()) {
      widget.flashcard.question = _question.text;
      widget.flashcard.answer = _answer.text;
      List<Flashcard> lista = [];
      lista.add(widget.flashcard);
      Provider.of<FlashcardRepository>(context, listen: false).saveAll(lista);
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
                        controller: _question,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            labelText: AppLocalizations.of(context)!.pergunta),
                        validator: (value) {
                          // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.insiraPergunta;
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: TextFormField(
                          maxLines: null,
                          controller: _answer,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              labelText:
                                  AppLocalizations.of(context)!.resposta),
                          validator: (value) {
                            // Valida o texto digitado pelo usuário de acordo com as condições abaixo
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .insiraResposta;
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
