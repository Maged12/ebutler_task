import 'dart:convert';

import 'package:ebutler_task/features/users_feature/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.avatar,
    required super.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
      'location': location,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] as String,
        avatar: map['avatar'] ?? "",
        location:
            map.containsKey("location") ? map["location"].toString() : "");
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
