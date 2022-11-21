import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../services/auth_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List Universitário'),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                }
              );
            }
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/clock-icon-removebg-preview.png'),
                  alignment: Alignment.center
                ),
                color: Colors.grey.withOpacity(0.2)
              ),
              child: Text(
                'CONFIGURAÇÕES',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange[800]
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () => PopupMenuButton(
                icon: Icon(Icons.more_horiz),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.flag, color: Colors.green),
                      title: Text('PT-BR'),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.highlight_remove_outlined, color: Colors.red),
                      title: Text('Remover Disciplina'),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey[800],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.language, color: Colors.black),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Linguagem',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () => context.read<AuthService>().logout(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.keyboard_return),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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