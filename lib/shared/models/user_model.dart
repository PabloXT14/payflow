import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String? photoUrl;

  UserModel({required this.name, required this.email, this.photoUrl});

  Map<String, dynamic> toMap() {
    return {"name": name, "email": email, "photoUrl": photoUrl};
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map["name"],
      email: map["email"],
      photoUrl: map["photoUrl"],
    );
  }

  factory UserModel.fromJson(String json) {
    return UserModel.fromMap(jsonDecode(json));
  }
}
