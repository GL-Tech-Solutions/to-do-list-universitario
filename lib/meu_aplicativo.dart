import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/locale_provider.dart';
import 'package:flutter_aula_1/widgets/auth_check.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

class MeuAplicativo extends StatelessWidget {
  //StatelessWidget - Um Widget imutável
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: ((context) => LocaleProvider()),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            title: 'Todo List - Universitário', //Título App
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                //Tema do App. É possível definir sua cor, tema escuro / tema claro, etc
                primarySwatch: Colors.deepOrange //Cor do tema
                ),
            locale: provider.locale,
            supportedLocales: [const Locale('pt', 'BR')],
            home:
                AuthCheck(), //Página inicial. Aqui puxamos uma classe que possui uma página montada pelo Scaffold
          );
        },
      );
}
