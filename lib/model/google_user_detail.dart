class GoogleUserDetail {
  String username;
  String email;

  GoogleUserDetail({required this.username, required this.email});

  Map<String, dynamic> toFirestore() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    return data;
  }

  factory GoogleUserDetail.fromFirestore(Map<String, dynamic> json) {
    return GoogleUserDetail(
      username: json['username'],
      email: json['email'],
    );
  }
}
