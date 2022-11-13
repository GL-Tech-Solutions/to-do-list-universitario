import 'dart:collection';
import 'package:flutter_aula_1/repositories/provider_listar.dart';
import '../models/tarefa.dart';

class ListarTarefas{
  final lista = ProviderListar().get();
  final List<Tarefa> _listaPendentes = [];
  final List<Tarefa> _listaConcluidas = [];
  
  UnmodifiableListView<Tarefa> get listaP => UnmodifiableListView(_listaPendentes);
  UnmodifiableListView<Tarefa> get listaC => UnmodifiableListView(_listaConcluidas);

  void listarPendentes()
  {
    lista.forEach((tarefa)
    { 
      if(!_listaPendentes.contains(tarefa) && tarefa.status == 'Aberto') {
        _listaPendentes.add(tarefa);
      }
    });
  }

  void listarConcluidas()
  {
    lista.forEach((tarefa)
    { 
      if(!_listaConcluidas.contains(tarefa) && tarefa.status == 'Finalizado') {
        _listaConcluidas.add(tarefa);
      }
    });
  }
}