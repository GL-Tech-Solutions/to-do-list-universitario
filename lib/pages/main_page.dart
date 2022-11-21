import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/tarefa.dart';
import 'package:flutter_aula_1/pages/configuracoes_page.dart';
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
  adicionarTarefa() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdiconarTarefaPage(),
      ),
    );
  }

  configuracoes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfiguracoesPage(),
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
            onPressed: configuracoes,
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
    dataSource: TarefasACumprir(getTarefas()),
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

List<Appointment> getTarefas(){
  List<Appointment> tarefas = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day,9,0,0);
  final DateTime endTime = startTime.add(Duration());

  tarefas.add(Appointment(startTime: startTime, endTime: endTime));
  return tarefas;
}

class TarefasACumprir extends CalendarDataSource{
  TarefasACumprir(List<Appointment> source){
    appointments = source;
  }
}