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

  _readDisciplinas() async {
    if (auth.usuario != null) {
      _lista = [];
      final snaphot = await db.collection('usuarios/${auth.usuario!.uid}/disciplinas').get(); //É possível fazer uma query direto no firebase (where por exemplo)
      snaphot.docs.forEach((doc) { 
        Disciplina disciplina = Disciplina(cod: doc.id, nome: doc.get('nome'), professor: doc.get('professor'), cor: Disciplina.toColor(doc.get('cor')));
        _lista.add(disciplina);
        _lista.sort((a, b) => a.nome.compareTo(b.nome));
        notifyListeners();
      });
    }
  }

  UnmodifiableListView<Disciplina> get lista => UnmodifiableListView(_lista);

  saveAll(List<Disciplina> disciplinas) {
    disciplinas.forEach((disciplina) async { 
        await db.collection('usuarios/${auth.usuario!.uid}/disciplinas')
          .doc(disciplina.cod ?? null)
          .set({
            'nome': disciplina.nome,
            'professor': disciplina.professor,
            'cor': disciplina.cor.toString(),
          });
      }
    );
    _readDisciplinas();
    notifyListeners();
  }

  remove(Disciplina disciplina) async {
    await db
      .collection('usuarios/${auth.usuario!.uid}/disciplinas')
      .doc(disciplina.cod)
      .delete();
    _lista.remove(disciplina);
    notifyListeners();
  }
}