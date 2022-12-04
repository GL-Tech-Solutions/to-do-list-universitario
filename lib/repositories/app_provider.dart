import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_aula_1/repositories/flashcard_repository.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';
import 'package:provider/provider.dart';
import 'disposable_provider.dart';

class AppProvider {
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      //Provider.of<TarefaRepository>(context, listen: false),
      Provider.of<FlashcardRepository>(context, listen: false),
      //...other disposable providers
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }
}