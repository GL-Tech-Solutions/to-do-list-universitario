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
    startRepository();
  }

  startRepository() async {
    _startFirestore();
    await readFlashcards();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  readFlashcards() async {
    if (auth.usuario != null) {
      _lista = [];
      final snaphot = await db
          .collection('usuarios/${auth.usuario!.uid}/flashcards')
          .get(); //É possível fazer uma query direto no firebase (where por exemplo)
      // ignore: avoid_function_literals_in_foreach_calls
      snaphot.docs.forEach((doc) {
        Flashcard flashcard = Flashcard(
            cod: doc.id,
            question: doc.get('question'),
            answer: doc.get('answer'));
        _lista.add(flashcard);
      });
      notifyListeners();
    }
  }

  UnmodifiableListView<Flashcard> get listaFlashcard =>
      UnmodifiableListView(_lista);

  saveAll(List<Flashcard> flashcards) {
    // ignore: avoid_function_literals_in_foreach_calls
    flashcards.forEach((flashcard) async {
      await db
          .collection('usuarios/${auth.usuario!.uid}/flashcards')
          .doc(flashcard.cod)
          .set({'question': flashcard.question, 'answer': flashcard.answer});
    });
    readFlashcards();
  }

  remove(Flashcard flashcard) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/flashcards')
        .doc(flashcard.cod)
        .delete();
    _lista.remove(flashcard);
    notifyListeners();
  }

  void resetLists() {
    _lista = [];
  }
}
