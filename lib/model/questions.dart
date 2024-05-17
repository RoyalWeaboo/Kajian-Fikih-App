class Question {
  String docId;
  String question;
  String a;
  String b;
  String c;
  String d;
  String correctAnswer;
  Question({
    required this.docId,
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.correctAnswer,
  });

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docId'] = docId;
    data['question'] = question;
    data['a'] = a;
    data['b'] = b;
    data['c'] = c;
    data['d'] = d;
    data['correctAnswer'] = correctAnswer;

    return data;
  }

  factory Question.fromFirestore(Map<String, dynamic> json) {
    return Question(
      docId: json['docId'],
      question: json['question'],
      a: json['a'],
      b: json['b'],
      c: json['c'],
      d: json['d'],
      correctAnswer: json['correctAnswer'],
    );
  }
}
