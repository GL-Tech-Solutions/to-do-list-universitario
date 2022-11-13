import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';

import '../models/tarefa.dart';

class ProviderListar extends ChangeNotifier{
  final _lista = TarefaRepository.tabela;
  
  List<Tarefa> get()
  {
    return _lista;
  }

  UnmodifiableListView<Tarefa> get lista => UnmodifiableListView(_lista);

  void refresh()
  {
    _lista.forEach((tarefa)
    { 
      if(!_lista.contains(tarefa))
        _lista.add(tarefa);
    });
    notifyListeners();
  }

  void remove(Tarefa tarefa)
  {
    _lista.remove(tarefa);
    notifyListeners();
  }
}