import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/repositories/disciplina_repository.dart';
import 'package:flutter_aula_1/repositories/flashcard_repository.dart';
import 'package:flutter_aula_1/repositories/pdf_api.dart';
import 'package:flutter_aula_1/repositories/selecionadas_repository.dart';
import 'package:flutter_aula_1/repositories/tarefa_respository.dart';
import 'package:flutter_aula_1/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'meu_aplicativo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sp = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => Selecionadas()),
        Provider(create: (context) => PDFApi()),
        ChangeNotifierProvider(
            create: (context) =>
                FlashcardRepository(auth: context.read<AuthService>())),
        ChangeNotifierProvider(
            create: (context) =>
                DisciplinaRepository(auth: context.read<AuthService>())),
        ChangeNotifierProvider(
            create: (context) => TarefaRepository(
                auth: context.read<AuthService>(),
                drepository: context.read<DisciplinaRepository>())),
      ],
      child: MeuAplicativo(sp: sp),
    ),
  );
}
