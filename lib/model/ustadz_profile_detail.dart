import 'package:kajian_fikih/model/offline_event.dart';

class UstadzProfileDetail {
  final String uid;
  final int kajianCount;
  final int followerCount;
  final List<OfflineEvent>? offlineEvents;

  UstadzProfileDetail({
    required this.uid,
    required this.kajianCount,
    required this.followerCount,
    this.offlineEvents,
  });

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['kajianCount'] = kajianCount;
    data['followerCount'] = followerCount;
    data['offlineEvents'] = offlineEvents;
    return data;
  }

  factory UstadzProfileDetail.fromFirestore(Map<String, dynamic> json) {
    return UstadzProfileDetail(
      uid: json['uid'],
      kajianCount: json['kajianCount'],
      followerCount: json['followerCount'],
      offlineEvents: json['offlineEvents'],
    );
  }
}
