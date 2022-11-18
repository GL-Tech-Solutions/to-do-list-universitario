import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'adicionar_flashcards_page.dart';

class FlashCardsPage extends StatefulWidget {
  const FlashCardsPage({Key? key}) : super(key: key);

  @override
  State<FlashCardsPage> createState() => _FlashCardsPageState();
}

class _FlashCardsPageState extends State<FlashCardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlashCards'),
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: (() => AdicionarFlashcardsPage()),
            elevation: 5,
            backgroundColor: Colors.deepOrange[400],
            child: Icon(Icons.add, size: 30,)
         ),
    );
  }
}