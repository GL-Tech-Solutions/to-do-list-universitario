import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/flashcards_page.dart';
import 'package:flutter_aula_1/pages/main_page.dart';
import 'package:flutter_aula_1/pages/tarefas_page.dart';
import 'package:flutter_aula_1/pages/disciplinas_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  setPaginaAtual(pagina) {
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
          MainPage(pc: pc),
          DisciplinasPage(pc: pc),
          TarefasPage(),
          FlashCardsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppLocalizations.of(context)!.inicio),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: AppLocalizations.of(context)!.disciplina),
          BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: AppLocalizations.of(context)!.tarefas),
          BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: AppLocalizations.of(context)!.flashCards),
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
