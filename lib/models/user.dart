class UserModel {
  String? uid;
  String? displayName;
  String? username;
  String? email;
  String? role;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.username,
    required this.email,
    required this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    displayName = json['name'];
    username = json['username'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uid;
    data['name'] = displayName;
    data['username'] = username;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
