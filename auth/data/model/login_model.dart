import 'package:smp/features/auth/domain/entity/login_entity.dart';
import 'package:smp/features/profile/data/model/user_model.dart';

class LoginModel extends LoginEntity {
  const LoginModel(
      {required super.message, required super.token, required super.user});

  factory LoginModel.fromJson(json) => LoginModel(
      message: json['message'],
      token: json['token'],
      user: UserModel.fromJson(json['user']));
}

