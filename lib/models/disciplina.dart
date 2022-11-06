// Classe model para as disciplinas
import 'package:flutter/material.dart';

class Disciplina {
  int cod;
  MaterialColor cor;
  String nome;
  String professor;
  String? descricao;

  Disciplina({
    required this.cod,
    required this.cor,
    required this.nome,
    required this.professor,
    this.descricao,
  });
}