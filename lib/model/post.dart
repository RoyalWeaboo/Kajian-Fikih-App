import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
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
  final Timestamp timestamp;

  Post({
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

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['docId'] = docId;
    data['poster'] = poster;
    data['posterProfileImage'] = posterProfileImage;
    data['postTitle'] = postTitle;
    data['postContent'] = postContent;
    data['category'] = category;
    data['youtubeLink'] = youtubeLink;
    data['imageUrl'] = imageUrl;
    data['watchCount'] = watchCount;
    data['likeCount'] = likeCount;
    data['timestamp'] = timestamp;

    return data;
  }

  factory Post.fromFirestore(Map<String, dynamic> json) {
    return Post(
      uid: json['uid'],
      docId: json['docId'],
      poster: json['poster'],
      posterProfileImage: json['posterProfileImage'],
      postTitle: json['postTitle'],
      postContent: json['postContent'],
      category: json['category'],
      youtubeLink: json['youtubeLink'],
      imageUrl: json['imageUrl'],
      likeCount: json['likeCount'],
      watchCount: json['watchCount'],
      timestamp: json['timestamp'],
    );
  }
}
