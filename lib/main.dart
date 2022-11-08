import 'package:flutter/material.dart';
import 'package:flutter_aula_1/configs/app_setting.dart';
import 'package:flutter_aula_1/repositories/listar_tarefas.dart';
import 'package:provider/provider.dart';
import 'meu_aplicativo.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => ListarTarefas()),
      ],
      child: MeuAplicativo(),
    ),
  );
}