part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable{}
class CountDownEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
}
class LoginEvent extends AuthEvent{
  final String email,password;
  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email,password];
}
class RegisterEvent extends AuthEvent{
  final String email,password,name,userName;
  RegisterEvent({required this.email, required this.password,required this.name,required this.userName});

  @override
  List<Object?> get props => [email,password,name,userName];
}
class VerifyEvent extends AuthEvent{
  final String otp;
  VerifyEvent({required this.otp});

  @override
  List<Object?> get props => [otp];
}
class ForgetPasswordEvent extends AuthEvent{
  final String email;
  ForgetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}
class ResetPasswordEvent extends AuthEvent{
  final String password,confirmPassword;
  ResetPasswordEvent({required this.password,required this.confirmPassword});

  @override
  List<Object?> get props => [password,confirmPassword];
}
class ResendCodeEvent extends AuthEvent{
  final String email;
  ResendCodeEvent({required this.email});

  @override
  List<Object?> get props => [email];
}
