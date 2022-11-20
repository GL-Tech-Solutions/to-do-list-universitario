import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/tarefa.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'adicionar_tarefa_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
late List<Tarefa> _tarefas;

  
  @override
void initState() {
  super.initState();
  _tarefas= {} as List<Tarefa>;
}
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
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List Universitário'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: null,
          ),
        ],
      ),
      body: 
      Row(
        children: [
          Container(
            alignment: Alignment.center,
            child: SfCalendar(
    view: CalendarView.month,
      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: (() => adicionarTarefa()),
            elevation: 5,
            backgroundColor: Colors.deepOrange[400],
            child: Icon(Icons.add, size: 30,)
            ),
    );
  }
}