import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/card.dart';
import '../models/flashcard.dart';
import 'adicionar_flashcards_page.dart';

class FlashCardsPage extends StatefulWidget {
  const FlashCardsPage({Key? key}) : super(key: key);
  

  @override
  State<FlashCardsPage> createState() => _FlashCardsPageState();
  
}

class _FlashCardsPageState extends State<FlashCardsPage> {
    int _currentIndexNumber = 0;
  double _initial = 0.1;

adicionarFlashcard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdicionarFlashcardsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlashCards'),
      ),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text("Você consegue!"),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.pinkAccent), 
                  // TODO trocar a cor da barra para a cor da disciplina
                  minHeight: 5,
                  value: _initial,
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                  width: 300,
                  height: 300,
                  child: FlipCard(
                      direction: FlipDirection.VERTICAL,
                      front: ReusableCard(
                          text: quesAnsList[_currentIndexNumber].question),
                      back: ReusableCard(
                          text: quesAnsList[_currentIndexNumber].answer))),
              Text("Toque para ver a resposta"),
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton.icon(
                        onPressed: () {
                          showPreviousCard();
                          updateToPrev();
                        },
                        icon: Icon(Icons.skip_previous, size: 30),
                        label: Text(""),
                        style: ElevatedButton.styleFrom(
                           // primary: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.only(
                                right: 20, left: 25, top: 15, bottom: 15))),
                    ElevatedButton.icon(
                        onPressed: () {
                          showNextCard();
                          updateToNext();
                        },
                        icon: Icon(Icons.skip_next, size: 30),
                        label: Text(""),
                        style: ElevatedButton.styleFrom(
                            //primary: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.only(
                                right: 20, left: 25, top: 15, bottom: 15)))
                  ])
        ]
      )
    ),     floatingActionButton: FloatingActionButton(
            onPressed: (() => adicionarFlashcard()),
            elevation: 5,
            backgroundColor: Colors.deepOrange[400],
            child: Icon(Icons.add, size: 30,)
         ),
    );
  }

  void updateToNext() {
    setState(() {
      _initial = _initial + 0.1;
      if (_initial > 1.0) {
        _initial = 0.1;
      }
    });
  }

  void updateToPrev() {
    setState(() {
      _initial = _initial - 0.1;
      if (_initial < 0.1) {
        _initial = 1.0;
      }
    });
  }

  void showNextCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber + 1 < quesAnsList.length)
          ? _currentIndexNumber + 1
          : 0;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber - 1 >= 0)
          ? _currentIndexNumber - 1
          : quesAnsList.length - 1;
    });
  }
}
 