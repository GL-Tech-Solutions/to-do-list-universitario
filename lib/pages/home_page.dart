import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/tarefas_page.dart';
import 'package:flutter_aula_1/pages/disciplinas_page.dart';

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
        // ignore: sort_child_properties_last
        children: [
          DisciplinasPage(),
          DisciplinasPage(),
          TarefasPage(),
          TarefasPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Disciplinas'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tarefas'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Flashcards'),
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