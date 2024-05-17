import 'package:cloud_firestore/cloud_firestore.dart';

class OfflineEvent {
  final String uid;
  final String docId;
  final String poster;
  final String posterProfileImage;
  final String postTitle;
  final String postContent;
  final String? imageUrl;
  final String category;
  final String date;
  final String timeStart;
  final String timeEnd;
  final String location;
  final String locationAddress;
  final String locationUrl;
  final Timestamp timestamp;

  OfflineEvent({
    required this.uid,
    required this.docId,
    required this.poster,
    required this.posterProfileImage,
    required this.postTitle,
    required this.postContent,
    this.imageUrl,
    required this.category,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.locationAddress,
    required this.locationUrl,
    required this.timestamp,
  });

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['docId'] = docId;
    data['poster'] = poster;
    data['posterProfileImage'] = posterProfileImage;
    data['postTitle'] = postTitle;
    data['postContent'] = postContent;
    data['imageUrl'] = imageUrl;
    data['category'] = category;
    data['date'] = date;
    data['timeStart'] = timeStart;
    data['timeEnd'] = timeEnd;
    data['location'] = location;
    data['locationAddress'] = locationAddress;
    data['locationUrl'] = locationUrl;
    data['timestamp'] = timestamp;

    return data;
  }

  factory OfflineEvent.fromFirestore(Map<String, dynamic> json) {
    return OfflineEvent(
      uid: json['uid'],
      docId: json['docId'],
      poster: json['poster'],
      posterProfileImage: json['posterProfileImage'],
      postTitle: json['postTitle'],
      postContent: json['postContent'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      date: json['date'],
      timeStart: json['timeStart'],
      timeEnd: json['timeEnd'],
      location: json['location'],
      locationAddress: json['locationAddress'],
      locationUrl: json['locationUrl'],
      timestamp: json['timestamp'],
    );
  }
}
