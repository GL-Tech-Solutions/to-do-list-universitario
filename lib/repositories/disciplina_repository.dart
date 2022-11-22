import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/database/db_firestore.dart';
import 'package:flutter_aula_1/models/disciplina.dart';

import '../services/auth_service.dart';

class DisciplinaRepository extends ChangeNotifier {
  List<Disciplina> _lista = [];
  late FirebaseFirestore db;
  late AuthService auth;

  DisciplinaRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readDisciplinas();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  MaterialColor getColor(String color) {
    if (color == 'Colors.green')
    {
      return Colors.green;
    }
    else if (color == 'Colors.blue') {
      return Colors.blue;
    }
    else {
      return Colors.amber;
    }
  }

  _readDisciplinas() async {
    if (auth.usuario != null && _lista.isEmpty) {
      final snaphot = await db.collection('usuarios/${auth.usuario!.uid}/disciplinas').get(); //É possível fazer uma query direto no firebase (where por exemplo)
      snaphot.docs.forEach((doc) { 
        Disciplina disciplina = Disciplina(cod: doc.get('cod'), nome: doc.get('nome'), professor: doc.get('professor'), cor: getColor(doc.get('cor')));
        _lista.add(disciplina);
        notifyListeners();
      });
    }
  }

  UnmodifiableListView<Disciplina> get lista => UnmodifiableListView(_lista);

  saveAll(List<Disciplina> disciplinas) {
    disciplinas.forEach((disciplina) async { 
      if (!_lista.any((atual) => atual.cod == disciplina.cod)) {
        _lista.add(disciplina);
        await db.collection('usuarios/${auth.usuario!.uid}/disciplinas')
          .doc(disciplina.cod.toString())
          .set({
            'cod': disciplina.cod,
            'nome': disciplina.nome,
            'professor': disciplina.professor,
            'cor': disciplina.cor,
          });
      }
    });
    notifyListeners();
  }

  remove(Disciplina disciplina) async {
    await db
      .collection('usuarios/${auth.usuario!.uid}/disciplinas')
      .doc(disciplina.cod.toString())
      .delete();
    _lista.remove(disciplina);
    notifyListeners();
  }

  /*static List<Disciplina> tabela = [
    Disciplina(
      cod: 0,
      cor: Colors.primaries[0], 
      nome: 'Segurança da Informação', 
      professor: 'André Luiz',
    ),
    Disciplina(
      cod: 1,
      cor: Colors.primaries[3], 
      nome: 'Programação para Dispositivos Móveis', 
      professor: 'José William',
    ),
    Disciplina(
      cod: 2,
      cor: Colors.primaries[5], 
      nome: 'Programação Linear', 
      professor: 'Carlos Fragoso',
    ),
    Disciplina(
      cod: 3,
      cor: Colors.primaries[1], 
      nome: 'Engenharia de Software III', 
      professor: 'Simone',
    ),
    Disciplina(
      cod: 4,
      cor: Colors.primaries[8], 
      nome: 'Inglês V', 
      professor: 'Elenir',
    ),
    Disciplina(
      cod: 5,
      cor: Colors.primaries[17], 
      nome: 'Laboratório de Banco de Dados', 
      professor: 'Marcio',
    ),
    Disciplina(
      cod: 6,
      cor: Colors.primaries[12], 
      nome: 'Sistemas Operacionais II', 
      professor: 'Helder',
    ),
  ];*/
}