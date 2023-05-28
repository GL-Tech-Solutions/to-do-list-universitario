// ignore_for_file: public_member_api_docs, sort_constructors_first
// Classe model para as disciplinas
import 'dart:convert';
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

  Disciplina copyWith({
    String? cod,
    Color? cor,
    String? nome,
    String? professor,
  }) {
    return Disciplina(
      cod: cod ?? this.cod,
      cor: cor ?? this.cor,
      nome: nome ?? this.nome,
      professor: professor ?? this.professor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cod': cod,
      'cor': cor.toString(),
      'nome': nome,
      'professor': professor,
    };
  }

  factory Disciplina.fromMap(Map<String, dynamic> map) {
    return Disciplina(
      cod: map['cod'] != null ? map['cod'] as String : null,
      cor: toColor(map['cor']),
      nome: map['nome'] as String,
      professor: map['professor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Disciplina.fromJson(String source) =>
      Disciplina.fromMap(json.decode(source) as Map<String, dynamic>);
}
