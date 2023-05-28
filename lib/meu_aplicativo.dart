import 'package:flutter/material.dart';
import 'package:flutter_aula_1/widgets/auth_check.dart';
import 'package:flutter_aula_1/repositories/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeuAplicativo extends StatelessWidget {
  //StatelessWidget - Um Widget imutável
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final localeProvider = context.watch<LocaleProvider>();

          return MaterialApp(
            title: 'Todo List - Universitário', //Título App
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                //Tema do App. É possível definir sua cor, tema escuro / tema claro, etc
                primarySwatch: Colors.deepOrange //Cor do tema
                ),
            locale: localeProvider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home:
                AuthCheck(), //Página inicial. Aqui puxamos uma classe que possui uma página montada pelo Scaffold
          );
        },
      );
}
