import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable{
  final String message,token,otp;
  final RegisteredUserEntity user;

  const RegisterEntity({required this.message, required this.token, required this.user,required this.otp});

  @override
  List<Object?> get props => [message,user,token,otp];
}
class RegisteredUserEntity extends Equatable{
  final int id;
  final String name,userName,email;

  const RegisteredUserEntity({required this.id, required this.name, required this.userName, required this.email});

  @override
  List<Object?> get props => [id,name,userName,email];
}