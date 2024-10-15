import 'package:smp/features/auth/domain/entity/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel(
      {required super.message,
      required super.token,
      required super.user,
      required super.otp});

  factory RegisterModel.fromJson(json) => RegisterModel(
      message: json['message'],
      token: json['token'],
      user: UserModel.fromJson(json['user']),
      otp: "${json['otp']}");
}

class UserModel extends RegisteredUserEntity {
  const UserModel(
      {required super.id,
      required super.name,
      required super.userName,
      required super.email});

  factory UserModel.fromJson(json) => UserModel(
        id: json['id'],
        name: json['name'],
        userName: json['username'],
        email: json['email'],
      );
}
