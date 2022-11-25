import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aula_1/models/disciplina.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:provider/provider.dart';
import '../database/db_firestore.dart';
import '../models/tarefa.dart';
import '../services/auth_service.dart';

class TarefaRepository extends ChangeNotifier{
  late DisciplinaRepository drepository;
  late List<String?> codDisciplinas = [];
  List<Tarefa> _listaP = [];
  List<Tarefa> _listaC = [];
  late FirebaseFirestore db;
  late AuthService auth;

  TarefaRepository({required this.auth, required this.drepository}) {
    _startRepository();

  }

  _startRepository() async {
    await _startFirestore();
    await _listDisciplinas();
    await _readPendentes();
    await _readConcluidas();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _listDisciplinas() async {
    drepository.lista.forEach((disciplina) { 
      codDisciplinas.add(disciplina.cod);
    });
  }

  DateTime convertTimeStamp (Timestamp t) {
    DateTime date = t.toDate();
    return date;
  }

  _readPendentes() async {
    if (auth.usuario != null) {
      _listaP = [];
      codDisciplinas.forEach((cod) async {
        final snaphot = await db.collection('usuarios/${auth.usuario!.uid}/disciplinas/$cod/tarefas').where('status', isEqualTo: 'Aberto').get();//É possível fazer uma query direto no firebase (where por exemplo)
        snaphot.docs.forEach((doc) { 
        Tarefa tarefa = Tarefa(
          cod: doc.id,
          nome: doc.get('nome'),
          descricao: doc.get('descricao'),
          codDisciplina: doc.get('codDisciplina'),
          tipo: doc.get('tipo'),
          data: convertTimeStamp(doc.get('data')),
          status: doc.get('status'),
          visibilidade: doc.get('visibilidade')
        );
        _listaP.add(tarefa);
        _listaP.sort((a, b) => a.nome.compareTo(b.nome));
        notifyListeners();
        });
      });
    }
  }

  _readConcluidas() async {
    if (auth.usuario != null) {
      _listaC = [];
      codDisciplinas.forEach((cod) async {
        final snaphot = await db.collection('usuarios/${auth.usuario!.uid}/disciplinas/$cod/tarefas').where('status', isEqualTo: 'Finalizado').get();//É possível fazer uma query direto no firebase (where por exemplo)
        snaphot.docs.forEach((doc) { 
        Tarefa tarefa = Tarefa(
          cod: doc.id,
          nome: doc.get('nome'),
          descricao: doc.get('descricao'),
          codDisciplina: doc.get('codDisciplina'),
          tipo: doc.get('tipo'),
          data: convertTimeStamp(doc.get('data')),
          status: doc.get('status'),
          visibilidade: doc.get('visibilidade')
        );
        _listaC.add(tarefa);
        _listaC.sort((a, b) => a.nome.compareTo(b.nome));
        notifyListeners();
        });
      });
    }
  }

  UnmodifiableListView<Tarefa> get listaPendentes => UnmodifiableListView(_listaP);
  UnmodifiableListView<Tarefa> get listaConcluidas => UnmodifiableListView(_listaC);

  saveAll(List<Tarefa> tarefas) {
    tarefas.forEach((tarefa) async { 
        await db.collection('usuarios/${auth.usuario!.uid}/disciplinas/${tarefa.codDisciplina}/tarefas')
          .doc(tarefa.cod ?? null)
          .set({
            'nome': tarefa.nome,
            'descricao': tarefa.descricao,
            'codDisciplina': tarefa.codDisciplina,
            'tipo': tarefa.tipo,
            'data': tarefa.data,
            'status': tarefa.status,
            'visibilidade': tarefa.visibilidade
          });
      }
    );
    _readPendentes();
    _readConcluidas();
    notifyListeners();
  }

  remove(Tarefa tarefa) async {
    await db
      .collection('usuarios/${auth.usuario!.uid}/disciplinas/${tarefa.codDisciplina}/tarefas')
      .doc(tarefa.cod)
      .delete();
    if(tarefa.status == 'Aberto') {
      _listaP.remove(tarefa);
    }
    else if(tarefa.status == 'Finalizado') {
      _listaC.remove(tarefa);
    }
    notifyListeners();
  }

  setStatus(Tarefa tarefa) async {
    await db
      .collection('usuarios/${auth.usuario!.uid}/disciplinas/${tarefa.codDisciplina}/tarefas')
      .doc(tarefa.cod)
      .delete();
    if(tarefa.status == 'Aberto') {
      _listaP.remove(tarefa);
    }
    else if(tarefa.status == 'Finalizado') {
      _listaC.remove(tarefa);
    }
    notifyListeners();
  }
}