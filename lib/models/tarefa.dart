//Classe model para as tarefas
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/disciplina.dart';

class Tarefa {
  int cod;
  String nome;
  String? descricao;
  int codDisciplina;
  String tipo;
  DateTime data;
  String status;
  bool visibilidade;

  Tarefa({
    required this.cod,
    required this.nome,
    this.descricao,
    required this.codDisciplina,
    required this.tipo,
    required this.data,
    required this.status,
    required this.visibilidade,
  });
}