import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListarTarefasRepository extends ChangeNotifier{
  /*final _listaInicial = TarefaRepository.tabela;
  var _lista = TarefaRepository.tabela;
  
  UnmodifiableListView<Tarefa> get lista => UnmodifiableListView(_lista);
  
  List<Tarefa> get()
  {
    return _lista;
  }

  void refresh()
  {
    _lista = [];
    for (int i=0;i<_listaInicial.length;i++)
    { 
      if(!_lista.contains(_listaInicial.elementAt(i)))
      {
        _lista.add(_listaInicial.elementAt(i));
      }
    }
    notifyListeners();
  }

  void remove(Tarefa tarefa)
  {
    _lista.remove(tarefa);
    notifyListeners();
  }

  /*void listarConcluidas()
  {
    _lista.forEach((tarefa)
    { 
      if(!_listaConcluidas.contains(tarefa) && tarefa.status == 'Finalizado') {
        _listaConcluidas.add(tarefa);
      }
    });
  }*/*/
}