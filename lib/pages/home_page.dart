import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/flashcards_page.dart';
import 'package:flutter_aula_1/pages/main_page.dart';
import 'package:flutter_aula_1/pages/tarefas_page.dart';
import 'package:flutter_aula_1/pages/disciplinas_page.dart';
import 'package:flutter_aula_1/generated/intl/messages_all.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina)
  {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: setPaginaAtual,
        children: [
          MainPage(),
          DisciplinasPage(pc: pc),
          TarefasPage(),
          FlashCardsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: S.of(context).Inicio),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: S.of(context).Disciplinas),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: S.of(context).Tarefas),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: S.of(context).FlashCards),
        ],
        currentIndex: paginaAtual,
        onTap: (pagina) {
          pc.animateToPage(
            pagina, 
            duration: Duration(milliseconds: 200), 
            curve: Curves.ease,
          );
        },
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}