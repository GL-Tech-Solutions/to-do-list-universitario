import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas_repository.dart';
import 'package:flutter_aula_1/repositories/locale_provider.dart';
import 'package:flutter_aula_1/repositories/selecionadas_repository.dart';
import 'package:flutter_aula_1/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'meu_aplicativo.dart';
import 'package:flutter_aula_1/generated/intl/messages_all.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ListarTarefasRepository()),
        ChangeNotifierProvider(create: (context) => Selecionadas()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => DisciplinaRepository(
          auth: context.read<AuthService>()
        )),
      ],
      child: MeuAplicativo(),
    ),
  );
}