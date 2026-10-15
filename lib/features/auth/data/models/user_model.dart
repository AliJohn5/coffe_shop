import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String? name;

  const UserModel({required this.id, required this.email, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'] as String,
      name: json['name'] as String?,
    );
  }

  User toEntity() {
    return User(id: id, email: email, name: name);
  }
}
