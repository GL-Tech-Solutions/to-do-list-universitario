import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Flashcard {
  String? cod;
  String question;
  String answer;

  Flashcard({this.cod, required this.question, required this.answer});

  Flashcard copyWith({
    String? cod,
    String? question,
    String? answer,
  }) {
    return Flashcard(
      cod: cod ?? this.cod,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cod': cod,
      'question': question,
      'answer': answer,
    };
  }

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      cod: map['cod'] != null ? map['cod'] as String : null,
      question: map['question'] as String,
      answer: map['answer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Flashcard.fromJson(String source) =>
      Flashcard.fromMap(json.decode(source) as Map<String, dynamic>);
}
