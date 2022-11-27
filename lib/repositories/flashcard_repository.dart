import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/database/db_firestore.dart';
import '../models/flashcard.dart';
import '../services/auth_service.dart';

class FlashcardRepository extends ChangeNotifier {
  List<Flashcard> _lista = [];
  late FirebaseFirestore db;
  late AuthService auth;

  FlashcardRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readFlashcards();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readFlashcards() async {
    if (auth.usuario != null) {
      _lista = [];
      final snaphot = await db.collection('usuarios/${auth.usuario!.uid}/flashcards').get(); //É possível fazer uma query direto no firebase (where por exemplo)
      snaphot.docs.forEach((doc) { 
        Flashcard flashcard = Flashcard(cod: doc.id, question: doc.get('question'), answer: doc.get('answer'));
        _lista.add(flashcard);
        notifyListeners();
      });
    }
  }

  UnmodifiableListView<Flashcard> get listaFlashcard => UnmodifiableListView(_lista);

  saveAll(List<Flashcard> flashcards) {
    flashcards.forEach((flashcard) async { 
        await db.collection('usuarios/${auth.usuario!.uid}/flashcards')
          .doc(flashcard.cod ?? null)
          .set({
            'question': flashcard.question,
            'answer': flashcard.answer
          });
      }
    );
    _readFlashcards();
    notifyListeners();
  }

  remove(Flashcard flashcard) async {
    await db
      .collection('usuarios/${auth.usuario!.uid}/flashcards')
      .doc(flashcard.cod)
      .delete();
    _lista.remove(flashcard);
    notifyListeners();
  }
}