import 'package:flutter_aula_1/models/disciplina.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import '../models/tarefa.dart';

class TarefaRepository {
  late List<Disciplina> disciplinas;

  static List<Tarefa> tabela = [
    Tarefa(
      cod: 1,
      nome: 'Atividade padrão de projetos',
      descricao: '',
      codDisciplina: 1,
      tipo: 'Atividade',
      data: DateTime.parse('2022-11-06 18:00:00'),
      status: 'Finalizado',
      visibilidade: true,
    ),
    Tarefa(
      cod: 2,
      nome: 'Calculadora',
      descricao: 'Fazer uma calculadora no Android Studio',
      codDisciplina: 2,
      tipo: 'Trabalho',
      data: DateTime.parse('2022-11-22 18:00:00'),
      status: 'Aberto',
      visibilidade: true,
    ),
    Tarefa(
      cod: 3,
      nome: 'P2 Programação Linear',
      descricao: '',
      codDisciplina: 3,
      tipo: 'Prova',
      data: DateTime.parse('2022-02-12 18:00:00'),
      status: 'Aberto',
      visibilidade: false,
    ),
  ];
}