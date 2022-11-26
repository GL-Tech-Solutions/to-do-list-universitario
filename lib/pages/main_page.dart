import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../generated/l10n.dart';
import '../services/auth_service.dart';
import 'adicionar_tarefa_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late LocaleProvider provider;
  
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
    provider = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Titulo),
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
                S.of(context).Config,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange[800]
                ),
              ),
            ),
            //OutlinedButton(
              PopupMenuButton(
                icon: Icon(Icons.more_horiz),
                itemBuilder: (context) => 
                AppLocalizationDelegate().supportedLocales.map((op) => 
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.flag, color: Colors.green),
                      title: Text(op.toString()),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      onTap: () {
                        Provider.of<LocaleProvider>(context, listen: false).setLocale(op);
                        AppLocalizationDelegate().load(provider.locale);
                        Navigator.of(context).pop();
                      },
                    ),  
                  )).toList(),
              ),
            OutlinedButton(
              onPressed: () => context.read<AuthService>().logout(),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.keyboard_return),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).Sair,
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