import '../models/tarefa.dart';

class TarefaRepository {
  static List<Tarefa> tabela = [
    Tarefa(
      cod: 1,
      nome: 'Atividade padrão de projetos',
      descricao: '',
      codDisciplina: 4,
      tipo: 'Atividade',
      data: DateTime.parse('2022-11-20 20:20:00'),
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
      data: DateTime.parse('2022-11-12 23:59:00'),
      status: 'Aberto',
      visibilidade: false,
    ),
  ];
}