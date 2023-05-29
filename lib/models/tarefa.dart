import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
//Classe model para as tarefas

class Tarefa {
  String? cod;
  String nome;
  String? descricao;
  String? codDisciplina;
  String tipo;
  DateTime data;
  String? status;
  bool? visibilidade;
  int porcentagemConclusao;

  Tarefa({
    this.cod,
    required this.nome,
    this.descricao,
    required this.codDisciplina,
    required this.tipo,
    required this.data,
    this.status,
    this.visibilidade,
    required this.porcentagemConclusao,
  });

  Tarefa copyWith({
    String? cod,
    String? nome,
    String? descricao,
    String? codDisciplina,
    String? tipo,
    DateTime? data,
    String? status,
    bool? visibilidade,
    int? porcentagemConclusao,
  }) {
    return Tarefa(
      cod: cod ?? this.cod,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      codDisciplina: codDisciplina ?? this.codDisciplina,
      tipo: tipo ?? this.tipo,
      data: data ?? this.data,
      status: status ?? this.status,
      visibilidade: visibilidade ?? this.visibilidade,
      porcentagemConclusao: porcentagemConclusao ?? this.porcentagemConclusao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cod': cod,
      'nome': nome,
      'descricao': descricao,
      'codDisciplina': codDisciplina,
      'tipo': tipo,
      'data': data,
      'status': status,
      'visibilidade': visibilidade,
      'porcentagemConclusao': porcentagemConclusao,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      cod: map['cod'] != null ? map['cod'] as String : null,
      nome: map['nome'] as String,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      codDisciplina:
          map['codDisciplina'] != null ? map['codDisciplina'] as String : null,
      tipo: map['tipo'] as String,
      data: (map['data'] as Timestamp).toDate(),
      status: map['status'] != null ? map['status'] as String : null,
      visibilidade:
          map['visibilidade'] != null ? map['visibilidade'] as bool : null,
      porcentagemConclusao: map['porcentagemConclusao'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tarefa.fromJson(String source) =>
      Tarefa.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tarefa(cod: $cod, nome: $nome, descricao: $descricao, codDisciplina: $codDisciplina, tipo: $tipo, data: $data, status: $status, visibilidade: $visibilidade)';
  }
}
