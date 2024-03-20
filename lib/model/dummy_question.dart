class DummyQuestion {
  int id;
  String question;
  String a;
  String b;
  String c;
  String d;
  String correctAnswer;
  DummyQuestion(
    this.id,
    this.question,
    this.a,
    this.b,
    this.c,
    this.d,
    this.correctAnswer,
  );
}

List<DummyQuestion> dummyQuestion = [
  DummyQuestion(
      1,
      "Lorem ipsum dolor sit amet consectetur. Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl. Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.",
      "Lorem ipsum dolor sit amet consectetur.",
      "Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl.",
      "Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.",
      "Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl.",
      "a")
];
