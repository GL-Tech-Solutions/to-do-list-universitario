import 'dart:collection';
import 'dart:developer';
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
    //startRepository();
  }

  startRepository() async {
    _startFirestore();
    await readDisciplinas();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  readDisciplinas() async {
    if (auth.usuario != null) {
      _lista = [];
      final snaphot = await db
          .collection('usuarios/${auth.usuario!.uid}/disciplinas')
          .get(); //É possível fazer uma query direto no firebase (where por exemplo)
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snaphot.docs) {
        Disciplina disciplina =
            Disciplina.fromMap(doc.data()).copyWith(cod: doc.id);
        _lista.add(disciplina);
        _lista.sort((a, b) => a.nome.compareTo(b.nome));
      }
      notifyListeners();
    }
  }

  UnmodifiableListView<Disciplina> get lista => UnmodifiableListView(_lista);

  saveDisciplina(Disciplina disciplina) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/disciplinas')
        .add(disciplina.toMap());
    readDisciplinas();
  }

  updateDisciplina(Disciplina disciplina) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/disciplinas')
        .doc(disciplina.cod)
        .update(disciplina.toMap());
    readDisciplinas();
  }

  remove(Disciplina disciplina) async {
    /*final snapshot = await db
        .collection(
            'usuarios/${auth.usuario!.uid}/disciplinas/${disciplina.cod}/tarefas')
        .where('codDisciplina', isEqualTo: disciplina.cod)
        .get();
    snapshot.docs.forEach(
      (tarefa) async {
        await db
            .collection(
                'usuarios/${auth.usuario!.uid}/disciplinas/${disciplina.cod}/tarefas')
            .doc(tarefa.id)
            .delete();
      },
    );*/
    await db
        .collection('usuarios/${auth.usuario!.uid}/disciplinas')
        .doc(disciplina.cod)
        .delete();
    _lista.remove(disciplina);
    notifyListeners();
  }

  void resetLists() {
    _lista = [];
  }
}
