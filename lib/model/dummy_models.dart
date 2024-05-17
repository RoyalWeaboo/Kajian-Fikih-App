class DummyQuestion {
  String docId;
  String question;
  String a;
  String b;
  String c;
  String d;
  String correctAnswer;
  DummyQuestion(
    this.docId,
    this.question,
    this.a,
    this.b,
    this.c,
    this.d,
    this.correctAnswer,
  );

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
}

List<DummyQuestion> dummyQuestion = [
  DummyQuestion(
      "1",
      "Lorem ipsum dolor sit amet consectetur. Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl. Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.",
      "Lorem ipsum dolor sit amet consectetur.",
      "Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl.",
      "Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.",
      "Pharetra sit massa elementum rutrum phasellus eu mus pretium. Vestibulum est ac ac eget.Et sed cursus velit porttitor dui lectus. Tincidunt mattis blandit gravida arcu nisl.",
      "a")
];

class DummyComment {
  final String docId;
  final String uid;
  final String commenter;
  final String commenterProfileImage;
  final String comment;
  final String? imageUrl;
  final String timestamp;

  DummyComment({
    required this.docId,
    required this.uid,
    required this.commenter,
    required this.commenterProfileImage,
    required this.comment,
    this.imageUrl,
    required this.timestamp,
  });
}

List<DummyComment> dummyComments = [
  DummyComment(
      docId: "1",
      uid: "1",
      commenter: "Jamaah 1",
      commenterProfileImage:
          "https://upload.wikimedia.org/wikipedia/commons/d/d5/The_Royal_Navy_during_the_Second_World_War_A22113.jpg",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/d/d5/The_Royal_Navy_during_the_Second_World_War_A22113.jpg",
      comment: "Test",
      timestamp: "25 Mei 2024")
];

class DummyPost {
  final String uid;
  final String docId;
  final String poster;
  final String posterProfileImage;
  final String postTitle;
  final String postContent;
  final String category;
  final String? youtubeLink;
  final String? imageUrl;
  final int likeCount;
  final int watchCount;
  final String timestamp;

  DummyPost({
    required this.uid,
    required this.docId,
    required this.poster,
    required this.posterProfileImage,
    required this.postTitle,
    required this.postContent,
    required this.category,
    this.youtubeLink,
    this.imageUrl,
    required this.watchCount,
    required this.likeCount,
    required this.timestamp,
  });
}

List<DummyPost> dummyPost = [
  DummyPost(
      uid: "1",
      docId: "1",
      poster: "Test",
      posterProfileImage:
          "https://upload.wikimedia.org/wikipedia/commons/d/d5/The_Royal_Navy_during_the_Second_World_War_A22113.jpg",
      postTitle: "Test YT Link",
      postContent: "Tes",
      youtubeLink: "https://youtu.be/G1BcXol14u8?si=VhnEjxmuxcgUSti_",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/d/d5/The_Royal_Navy_during_the_Second_World_War_A22113.jpg",
      category: "A",
      watchCount: 1,
      likeCount: 1,
      timestamp: "25 Mei 2024")
];
