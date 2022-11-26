//Classe model para as tarefas

class Tarefa {
  String? cod;
  String nome;
  String? descricao;
  String? codDisciplina;
  String tipo;
  DateTime data;
  String? status;
  bool visibilidade;

  Tarefa({
    this.cod,
    required this.nome,
    this.descricao,
    required this.codDisciplina,
    required this.tipo,
    required this.data,
    this.status,
    required this.visibilidade,
  });
}