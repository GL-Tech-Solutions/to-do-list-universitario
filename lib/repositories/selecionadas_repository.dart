import 'package:flutter/cupertino.dart';
import '../models/tarefa.dart';

class Selecionadas extends ChangeNotifier {
  List<Tarefa> _selecionadas = [];

   List<Tarefa> get selecionadas => (_selecionadas);

  void iniciarSelecionadas(Tarefa t)
  {
    if (_selecionadas.isEmpty)
    {
      _selecionadas.add(t);
      notifyListeners();
    }
  }

  void adicionarSelecionada(Tarefa t)
  {
      _selecionadas.add(t);
      notifyListeners();
  }

  void limparSelecionada(Tarefa t)
  {
      _selecionadas.remove(t);
      notifyListeners();
  }

  void limparSelecionadas()
  {
      _selecionadas = [];
      notifyListeners();
  }
}