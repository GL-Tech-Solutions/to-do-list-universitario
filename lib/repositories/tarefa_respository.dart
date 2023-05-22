import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aula_1/models/disciplina.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import '../database/db_firestore.dart';
import '../models/tarefa.dart';
import '../services/auth_service.dart';

class TarefaRepository extends ChangeNotifier {
  DisciplinaRepository drepository;
  late FirebaseFirestore db;
  late AuthService auth;
  String? codDisciplinaFilter;

  TarefaRepository({required this.auth, required this.drepository}) {
    startRepository();
  }

  startRepository() {
    _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  Future<List<Tarefa>> readTarefas() async {
    try {
      List<Tarefa> tarefas = [];

      if (auth.usuario != null) {
        for (Disciplina disciplina in drepository.lista) {
          final snapshot = await db
              .collection(
                  'usuarios/${auth.usuario!.uid}/disciplinas/${disciplina.cod}/tarefas')
              .get();
          if (snapshot.docs.isNotEmpty) {
            tarefas.addAll(snapshot.docs
                .map(
                  (doc) => Tarefa.fromMap(
                    doc.data(),
                  ).copyWith(cod: doc.id),
                )
                .toList());
            tarefas.sort((a, b) => a.nome.compareTo(b.nome));
          }
        }
        return tarefas;
      }
      return tarefas;
    } on FirebaseException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      throw Exception('Houve um problema ao salvar a tarefa');
    }
  }

  Future<List<Tarefa>> readTarefasPendentes() async {
    try {
      List<Tarefa> tarefas = [];

      if (auth.usuario != null) {
        for (Disciplina disciplina in drepository.lista) {
          final snapshot = await db
              .collection(
                  'usuarios/${auth.usuario!.uid}/disciplinas/${disciplina.cod}/tarefas')
              .where('status', isEqualTo: 'Aberto')
              .get();
          if (snapshot.docs.isNotEmpty) {
            tarefas.addAll(snapshot.docs
                .map(
                  (doc) => Tarefa.fromMap(
                    doc.data(),
                  ).copyWith(cod: doc.id),
                )
                .toList());
            tarefas.sort((a, b) => a.nome.compareTo(b.nome));
          }
        }
        return tarefas;
      }
      return tarefas;
    } on FirebaseException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      throw Exception('Houve um problema ao salvar a tarefa');
    }
  }

  Future<List<Tarefa>> readTarefasConcluidas() async {
    try {
      List<Tarefa> tarefas = [];

      if (auth.usuario != null) {
        for (Disciplina disciplina in drepository.lista) {
          final snapshot = await db
              .collection(
                  'usuarios/${auth.usuario!.uid}/disciplinas/${disciplina.cod}/tarefas')
              .where('status', isEqualTo: 'Finalizado')
              .get();
          if (snapshot.docs.isNotEmpty) {
            tarefas.addAll(snapshot.docs
                .map(
                  (doc) => Tarefa.fromMap(
                    doc.data(),
                  ).copyWith(cod: doc.id),
                )
                .toList());
            tarefas.sort((a, b) => a.nome.compareTo(b.nome));
          }
        }
        return tarefas;
      }
      return tarefas;
    } on FirebaseException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      throw Exception('Houve um problema ao salvar a tarefa');
    }
  }

  Future<List<Tarefa>> readFiltered(String? codDisciplina) async {
    List<Tarefa> tarefas = [];

    if (auth.usuario != null) {
      if (codDisciplina != null) {
        final snapshot = await db
            .collection(
                'usuarios/${auth.usuario!.uid}/disciplinas/$codDisciplina/tarefas')
            .get();

        if (snapshot.docs.isNotEmpty) {
          tarefas.addAll(snapshot.docs
              .map(
                (doc) => Tarefa.fromMap(
                  doc.data(),
                ),
              )
              .toList());
          tarefas.sort((a, b) => a.nome.compareTo(b.nome));
          return tarefas;
        }
      }
    }
    return tarefas;
  }

  Future<void> saveTarefa(Tarefa tarefa) async {
    try {
      if (auth.usuario != null) {
        await db
            .collection(
                'usuarios/${auth.usuario!.uid}/disciplinas/${tarefa.codDisciplina}/tarefas')
            .add(tarefa.toMap());
        notifyListeners();
      }
    } on FirebaseException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      throw Exception('Houve um problema ao salvar a tarefa');
    }
  }

  Future<void> updateTarefa(Tarefa tarefa) async {
    try {
      if (auth.usuario != null) {
        await db
            .collection(
                'usuarios/${auth.usuario!.uid}/disciplinas/${tarefa.codDisciplina}/tarefas')
            .doc(tarefa.cod)
            .update(tarefa.toMap());
        notifyListeners();
      }
    } on FirebaseException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      throw Exception('Houve um problema ao atualizar a tarefa');
    }
  }

  remove(List<Tarefa> tarefas) async {
    try {
      if (auth.usuario != null) {
        for (Tarefa tarefa in tarefas) {
          await db
              .collection(
                  'usuarios/${auth.usuario!.uid}/disciplinas/${tarefa.codDisciplina}/tarefas')
              .doc(tarefa.cod)
              .delete();
        }
        notifyListeners();
      }
    } on FirebaseException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      throw Exception('Houve um problema ao atualizar a tarefa');
    }
  }

  setStatus(List<Tarefa> tarefas) async {
    for (Tarefa tarefa in tarefas) {
      if (tarefa.status == 'Aberto') {
        tarefa.status = 'Finalizado';
      } else if (tarefa.status == 'Finalizado') {
        tarefa.status = 'Aberto';
      }
      await updateTarefa(tarefa);
    }
    notifyListeners();
  }

  void setFilter(String? codDisciplina) {
    codDisciplinaFilter = codDisciplina;
    notifyListeners();
  }

  void clearFilter() {
    codDisciplinaFilter = null;
    notifyListeners();
  }
}
