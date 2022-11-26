import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/adicionar_tarefa_page.dart';
import 'package:flutter_aula_1/pages/concluidas_page.dart';
import 'package:flutter_aula_1/pages/pendentes_page.dart';
import 'package:flutter_aula_1/widgets/appbar_tarefas.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../generated/l10n.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> with SingleTickerProviderStateMixin {
  late TabController _controller;
  int abaAtual = 0;

  setPaginaAtual(aba)
  {
    setState(() {
      abaAtual = aba;
    });
  }
  
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, animationDuration: Duration(milliseconds: 200));
    _controller.animation?.addListener(() { 
      setPaginaAtual(_controller.index);
    });
  }

  TabBar get _tabBar => TabBar(
    indicatorColor: Colors.deepOrange[400],
    indicatorWeight: 3,
    labelColor: abaAtual == 0 ? Colors.red[800] : Colors.green,
    unselectedLabelColor: Colors.black.withOpacity(0.7),
    labelStyle: TextStyle(fontWeight: FontWeight.w600),
    controller: _controller,
    tabs: [
      Tab(text: S.of(context).Pendentes),
      Tab(text: S.of(context).Consluidas)
    ],
  );

  adicionarTarefa() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdiconarTarefaPage(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
      ],
      home: Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AppBarTarefas(tabBar: _tabBar),
          ];
        },
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.start,
          controller: _controller,
          physics: ClampingScrollPhysics(),
          children: [
            PendentesPage(),
            ConcluidasPage()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => adicionarTarefa()),
        elevation: 5,
        backgroundColor: Colors.deepOrange[400],
        child: Icon(Icons.add, size: 30,)
        ),
      ),
    );
  }
}