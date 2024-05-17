import 'package:cloud_firestore/cloud_firestore.dart';

class PostNotification {
  final String docId;
  final String uid;
  final String postDocId;
  final String postType;
  final String notificationTitle;
  final String notificationText;

  final Timestamp timestamp;

  PostNotification({
    required this.docId,
    required this.uid,
    required this.postDocId,
    required this.postType,
    required this.notificationTitle,
    required this.notificationText,
    required this.timestamp,
  });

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['docId'] = docId;
    data['postDocId'] = postDocId;
    data['postType'] = postType;
    data['notificationTitle'] = notificationTitle;
    data['notificationText'] = notificationText;
    data['timestamp'] = timestamp;

    return data;
  }

  factory PostNotification.fromFirestore(Map<String, dynamic> json) {
    return PostNotification(
      uid: json['uid'],
      docId: json['docId'],
      postDocId: json['postDocId'],
      postType: json['postType'],
      notificationTitle: json['notificationTitle'],
      notificationText: json['notificationText'],
      timestamp: json['timestamp'],
    );
  }
}
