// Classe model para as disciplinas
import 'package:flutter/material.dart';

class Disciplina {
  String? cod;
  Color cor;
  String nome;
  String professor;

  Disciplina({
    this.cod,
    required this.cor,
    required this.nome,
    required this.professor,
  });

  static Color toColor(String colorString) {
    colorString = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(colorString, radix: 16);
    return Color(value);
  }
}