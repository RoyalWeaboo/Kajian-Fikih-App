import 'package:cloud_firestore/cloud_firestore.dart';

class PostComment {
  final String docId;
  final String uid;
  final String commenter;
  final String commenterProfileImage;
  final String comment;
  final String? imageUrl;
  final Timestamp timestamp;

  PostComment({
    required this.docId,
    required this.uid,
    required this.commenter,
    required this.commenterProfileImage,
    required this.comment,
    this.imageUrl,
    required this.timestamp,
  });

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['docId'] = docId;
    data['commenter'] = commenter;
    data['commenterProfileImage'] = commenterProfileImage;
    data['comment'] = comment;
    data['imageUrl'] = imageUrl;
    data['timestamp'] = timestamp;

    return data;
  }

  factory PostComment.fromFirestore(Map<String, dynamic> json) {
    return PostComment(
      uid: json['uid'],
      docId: json['docId'],
      commenter: json['commenter'],
      commenterProfileImage: json['commenterProfileImage'],
      comment: json['comment'],
      imageUrl: json['imageUrl'],
      timestamp: json['timestamp'],
    );
  }
}
