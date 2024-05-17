class UserDetail {
  final String uid;
  final String username;
  final String phone;
  final String email;
  final String location;
  final String profilePictureUrl;
  final String role;
  final int? kajianCount;
  final int? followerCount;
  final String? description;

  UserDetail({
    required this.uid,
    required this.username,
    required this.phone,
    required this.email,
    required this.location,
    required this.profilePictureUrl,
    required this.role,
    this.kajianCount,
    this.followerCount,
    this.description,
  });

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['username'] = username;
    data['phone'] = phone;
    data['email'] = email;
    data['location'] = location;
    data['profilePictureUrl'] = profilePictureUrl;
    data['role'] = role;
    data['kajianCount'] = kajianCount;
    data['followerCount'] = followerCount;
    data['role'] = role;
    data['description'] = description;
    return data;
  }

  factory UserDetail.fromFirestore(Map<String, dynamic> json) {
    return UserDetail(
      uid: json['uid'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      location: json['location'],
      profilePictureUrl: json['profilePictureUrl'],
      role: json['role'],
      kajianCount: json['kajianCount'],
      followerCount: json['followerCount'],
      description: json['description'],
    );
  }
}
