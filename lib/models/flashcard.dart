class Flashcard {
  String? cod;
  String question;
  String answer;

  Flashcard({this.cod ,required this.question, required this.answer});
}

List<Flashcard> quesAnsList = [
  Flashcard(
      question: "O que é microsserviço?",
      answer: "Microsserviços são uma abordagem arquitetônica e organizacional do desenvolvimento de software na qual o software consiste em pequenos serviços independentes que se comunicam usando APIs bem definidas."),
  Flashcard(
      question: "Quais são os padrões de projeto estrturais?",
      answer: "Adapter, Bridge, Composite, Decorator, Facade, Flyweight e Proxy"),
  Flashcard(
      question: "Outra questão",
      answer: "Resposta aqui"),
  Flashcard(
      question: "Uma mais questão",
      answer: "Resposta"),    
];