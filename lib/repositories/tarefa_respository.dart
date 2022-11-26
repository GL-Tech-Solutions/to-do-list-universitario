import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import '../database/db_firestore.dart';
import '../models/tarefa.dart';
import '../services/auth_service.dart';

class TarefaRepository extends ChangeNotifier{
  late DisciplinaRepository drepository;
  late List<String?> codDisciplinas = [];
  List<Tarefa> _listaP = [];
  List<Tarefa> _listaC = [];
  String? _cod = null;
  late FirebaseFirestore db;
  late AuthService auth;

  TarefaRepository({required this.auth, required this.drepository}) {
    _startRepository();

  }

  _startRepository() async {
    await _startFirestore();
    await _listDisciplinas();
    await _readPendentes(_cod);
    await _readConcluidas(_cod);
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

  _readPendentes(String? codDisciplina) async {
    if (auth.usuario != null) {
      _listaP = [];
      codDisciplinas.forEach((cod) async {
        final snapshot;
        if (codDisciplina != null) {
          snapshot = await db.collection('usuarios/${auth.usuario!.uid}/disciplinas/$cod/tarefas')
          .where('status', isEqualTo: 'Aberto')
          .where('codDisciplina', isEqualTo: codDisciplina)
          .get();//É possível fazer uma query direto no firebase (where por exemplo)
        }
        else {
          snapshot = await db.collection('usuarios/${auth.usuario!.uid}/disciplinas/$cod/tarefas')
          .where('status', isEqualTo: 'Aberto')
          .get();//É possível fazer uma query direto no firebase (where por exemplo)
        }
        snapshot.docs.forEach((doc) { 
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

  _readConcluidas(String? codDisciplina) async {
    if (auth.usuario != null) {
      _listaC = [];
      codDisciplinas.forEach((cod) async {
        final snapshot;
        if (codDisciplina != null) {
          snapshot = await db.collection('usuarios/${auth.usuario!.uid}/disciplinas/$cod/tarefas')
          .where('status', isEqualTo: 'Finalizado')
          .where('codDisciplina', isEqualTo: codDisciplina)
          .get();//É possível fazer uma query direto no firebase (where por exemplo)
        }
        else {
          snapshot = await db.collection('usuarios/${auth.usuario!.uid}/disciplinas/$cod/tarefas')
          .where('status', isEqualTo: 'Finalizado')
          .get();//É possível fazer uma query direto no firebase (where por exemplo)
        }
        snapshot.docs.forEach((doc) { 
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

  set cod(String? codDisciplina) {
    _cod = codDisciplina;
    _readPendentes(_cod);
    _readConcluidas(_cod);
    notifyListeners();
  }

  clearFiltered()
  {
    _cod = null;
    _readPendentes(_cod);
    _readConcluidas(_cod);
    notifyListeners();
  }

  String? get cod => (_cod);
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
    _readPendentes(_cod);
    _readConcluidas(_cod);
    notifyListeners();
  }

  remove(List<Tarefa> tarefas) async {
    tarefas.forEach((tarefa) async {
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
    });
  }

  setStatus(List<Tarefa> tarefas) async {
    tarefas.forEach((tarefa) async {
      if(tarefa.status == 'Aberto') {
      tarefa.status = 'Finalizado';
      _listaP.remove(tarefa);
      _listaC.add(tarefa);
      }
      else if(tarefa.status == 'Finalizado') {
      tarefa.status = 'Aberto';
      _listaC.remove(tarefa);
      _listaP.add(tarefa);
      }
      await db
        .collection('usuarios/${auth.usuario!.uid}/disciplinas/${tarefa.codDisciplina}/tarefas')
        .doc(tarefa.cod)
        .set({
          'nome': tarefa.nome,
          'descricao': tarefa.descricao,
          'codDisciplina': tarefa.codDisciplina,
          'tipo': tarefa.tipo,
          'data': tarefa.data,
          'status': tarefa.status,
          'visibilidade': tarefa.visibilidade
        });
      notifyListeners();
    });
  }
}