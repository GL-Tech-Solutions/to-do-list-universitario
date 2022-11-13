import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';

import '../models/tarefa.dart';

class ListarTarefas extends ChangeNotifier{
  final _lista = TarefaRepository.tabela;
  final List<Tarefa> _listaPendentes = [];
  final List<Tarefa> _listaConcluidas = [];
  
  UnmodifiableListView<Tarefa> get lista => UnmodifiableListView(_lista);
  UnmodifiableListView<Tarefa> get listaP => UnmodifiableListView(_listaPendentes);
  UnmodifiableListView<Tarefa> get listaC => UnmodifiableListView(_listaConcluidas);

  void refresh()
  {
    _lista.forEach((tarefa)
    { 
      if(!_lista.contains(tarefa))
        _lista.add(tarefa);
    });
    notifyListeners();
  }

  void listarPendentes()
  {
    _lista.forEach((tarefa)
    { 
      if(tarefa.status == 'Aberto') {
        _listaPendentes.add(tarefa);
      }
    });
  }

  void listarConcluidas()
  {
    _lista.forEach((tarefa)
    { 
      if(tarefa.status == 'Finalizado') {
        _listaConcluidas.add(tarefa);
      }
    });
  }

  void remove(Tarefa tarefa)
  {
    _lista.remove(tarefa);
    notifyListeners();
  }
}