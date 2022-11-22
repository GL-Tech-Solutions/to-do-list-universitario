import 'package:flutter_aula_1/models/disciplina.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import '../models/tarefa.dart';

class TarefaRepository {
  late List<Disciplina> disciplinas;

  static List<Tarefa> tabela = [
    Tarefa(
      cod: 0,
      nome: 'Atividade padrão de projetos',
      descricao: '',
      codDisciplina: 0,
      tipo: 'Atividade',
      data: DateTime.parse('2022-11-06 18:00:00'),
      status: 'Aberto',
      visibilidade: true,
    ),
    Tarefa(
      cod: 1,
      nome: 'Calculadora',
      descricao: 'Fazer uma calculadora no Android Studio',
      codDisciplina: 0,
      tipo: 'Trabalho',
      data: DateTime.parse('2022-11-22 18:00:00'),
      status: 'Aberto',
      visibilidade: true,
    ),
    Tarefa(
      cod: 2,
      nome: 'P2 Programação Linear',
      descricao: '',
      codDisciplina: 0,
      tipo: 'Prova',
      data: DateTime.parse('2022-02-12 18:00:00'),
      status: 'Aberto',
      visibilidade: false,
    ),
    Tarefa(
      cod: 3,
      nome: 'Um trabalho a fazer',
      descricao: '',
      codDisciplina: 0,
      tipo: 'Trabalho',
      data: DateTime.parse('2022-02-12 18:00:00'),
      status: 'Aberto',
      visibilidade: true,
    ),
    Tarefa(
      cod: 4,
      nome: 'Provinha hein',
      descricao: '',
      codDisciplina: 0,
      tipo: 'Prova',
      data: DateTime.parse('2022-02-12 18:00:00'),
      status: 'Aberto',
      visibilidade: false,
    ),
    Tarefa(
      cod: 5,
      nome: 'Uma atividade sobre To List e suas vantagens',
      descricao: '',
      codDisciplina: 0,
      tipo: 'Atividade',
      data: DateTime.parse('2022-02-12 18:00:00'),
      status: 'Aberto',
      visibilidade: false,
    ),
    Tarefa(
      cod: 6,
      nome: 'Mais outra prova heinn',
      descricao: '',
      codDisciplina: 0,
      tipo: 'Prova',
      data: DateTime.parse('2022-02-12 18:00:00'),
      status: 'Aberto',
      visibilidade: true,
    ),
  ];
}