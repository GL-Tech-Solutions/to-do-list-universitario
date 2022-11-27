import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/flashcard_repository.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../widgets/card.dart';
import '../models/flashcard.dart';
import 'adicionar_flashcard_page.dart';
import 'editar_flashcard_page.dart';

class FlashCardsPage extends StatefulWidget {
  const FlashCardsPage({Key? key}) : super(key: key);
  

  @override
  State<FlashCardsPage> createState() => _FlashCardsPageState();
  
}

class _FlashCardsPageState extends State<FlashCardsPage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  int _currentIndexNumber = 0;
  double _initial = (1 / quesAnsList.length);
  late FlashcardRepository flashrepository;

adicionarFlashcard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdicionarFlashcardPage(),
      ),
    );
  }

  editarFlashcard(Flashcard flashcard) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditarFlashCardPage(flashcard: flashcard),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    flashrepository = context.watch<FlashcardRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).FlashCards),
        actions: [
          PopupMenuButton(
            icon:
              Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.edit, color: Colors.blue),
                  title: Text(S.of(context).Editar),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  onTap: () => editarFlashcard(flashrepository.listaFlashcard[_currentIndexNumber])
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.add_circle_outline_rounded, color: Colors.green),
                  title: Text(S.of(context).Adicionar),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  onTap: () => adicionarFlashcard()
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.highlight_remove_outlined, color: Colors.red),
                  title: Text(S.of(context).Remover),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  onTap: () => Provider.of<FlashcardRepository>(context, listen: false).remove(flashrepository.listaFlashcard[_currentIndexNumber])
                ),
              ),
            ],
          ),
        ],
      ),
          body: Consumer<FlashcardRepository>(
            builder: (context, flashcards, child) {
             return flashcards.listaFlashcard.isEmpty
             ? Text('Você não possui flashcards')
             : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(flashcards.listaFlashcard.length.toDouble()),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(Colors.deepPurple), 
                    minHeight: 5,
                    value: _initial,
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                    width: 300,
                    height: 300,
                    child: FlipCard(
                      speed: 200,
                      key: cardKey,
                      direction: FlipDirection.VERTICAL,
                      front: ReusableCard(
                          text: flashcards.listaFlashcard[_currentIndexNumber].question),
                      back: ReusableCard(
                            text: flashcards.listaFlashcard[_currentIndexNumber].answer))),
                Text(S.of(context).VerResposta),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton.icon(
                          onPressed: () {
                            if (!cardKey.currentState!.isFront) {
                              cardKey.currentState!.toggleCard();
                            }
                            showPreviousCard();
                            updateToPrev();
                          },
                          icon: Icon(Icons.skip_previous, size: 30),
                          label: Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.only(
                                  right: 20, left: 25, top: 15, bottom: 15))),
                      ElevatedButton.icon(
                          onPressed: () {
                            if (!cardKey.currentState!.isFront) {
                              cardKey.currentState!.toggleCard();
                            }
                            showNextCard();
                            updateToNext();
                          },
                          icon: Icon(Icons.skip_next, size: 30),
                          label: Text(""),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.only(
                                  right: 20, left: 25, top: 15, bottom: 15)))
                    ])
                  ]
                )
              );
            }
          ),
    );
  }

  void updateToNext() {
    setState(() {
      _initial = _initial + (1 / flashrepository.listaFlashcard.length);
      if (_initial > 1.0) {
        _initial = (1 / flashrepository.listaFlashcard.length);
      }
    });
  }

  void updateToPrev() {
    setState(() {
      _initial = _initial - (1 / flashrepository.listaFlashcard.length);
      if (_initial < 0.1) {
        _initial = (1);
      }
    });
  }

  void showNextCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber + 1 < flashrepository.listaFlashcard.length)
          ? _currentIndexNumber + 1
          : 0;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber - 1 >= 0)
          ? _currentIndexNumber - 1
          : flashrepository.listaFlashcard.length - 1;
    });
  }
}
 