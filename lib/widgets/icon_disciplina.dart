import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/disciplina.dart';

class IconDisciplina extends StatefulWidget {
  final Disciplina disciplina;

  const IconDisciplina({super.key, required this.disciplina});

  @override
  State<IconDisciplina> createState() => _IconDisciplinaState();
}

class _IconDisciplinaState extends State<IconDisciplina> {
  String getInitials(String disciplineName) {
    var buffer = StringBuffer();
    var split = disciplineName.split(' ');
    String initial = "";
    int limit = 0;

    for (int i = 0; i < split.length; i++) {
      initial = split[i][0];
      if (initial == initial.toUpperCase()) {
        buffer.write(initial);
        limit++;
        if (limit == 2) {
          break;
        }
      }
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: widget.disciplina.cor,
      child: Text(
        getInitials(widget.disciplina.nome),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
