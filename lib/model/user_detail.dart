class UserDetail {
  final String uid;
  final String docId;
  final String username;
  final String phone;
  final String email;
  final String location;
  final String profilePictureUrl;
  final String role;

  UserDetail({
    required this.uid,
    required this.docId,
    required this.username,
    required this.phone,
    required this.email,
    required this.location,
    required this.profilePictureUrl,
    required this.role,
  });

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['docId'] = docId;
    data['username'] = username;
    data['phone'] = phone;
    data['email'] = email;
    data['location'] = location;
    data['profilePictureUrl'] = profilePictureUrl;
    data['role'] = role;
    return data;
  }

  factory UserDetail.fromFirestore(Map<String, dynamic> json) {
    return UserDetail(
      uid: json['uid'],
      docId: json['docId'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      location: json['location'],
      profilePictureUrl: json['profilePictureUrl'],
      role: json['role'],
    );
  }
}
