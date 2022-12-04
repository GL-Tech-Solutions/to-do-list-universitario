import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/home_page.dart';
import 'package:flutter_aula_1/repositories/flashcard_repository.dart';
import 'package:provider/provider.dart';

class LoadingFlashcardPage extends StatefulWidget {
  const LoadingFlashcardPage({super.key});

  @override
  State<LoadingFlashcardPage> createState() => _LoadingFlashcardPageState();
}

class _LoadingFlashcardPageState extends State<LoadingFlashcardPage> {
  @override
  Widget build(BuildContext context) {
    FlashcardRepository flashcardRepository = Provider.of<FlashcardRepository>(context);

    return FutureBuilder(
      future: flashcardRepository.initalizeFlashCards(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        }
        else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator(color: Colors.deepOrange)),
          );
        }
      },
    );
  }
}