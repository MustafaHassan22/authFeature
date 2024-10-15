part of 'auth_bloc.dart';

// abstract class AuthState {}
//
// final class AuthInitial extends AuthState {}
// final class CountDownLoadingState extends AuthState {}
// final class CountDownSuccessState extends AuthState {}
// final class CountDownFinishedState extends AuthState {}
// final class LoginLoadingState extends AuthState {}
// final class LoginSuccessState extends AuthState {
//   final String message;
//   LoginSuccessState({required this.message});
// }
// final class LoginFailureState extends AuthState {
//   final String message;
//   LoginFailureState({required this.message});
// }
// final class RegisterLoadingState extends AuthState {}
// final class RegisterSuccessState extends AuthState {
//   final String message;
//   RegisterSuccessState({required this.message});
// }
// final class RegisterFailureState extends AuthState {
//   final String message;
//   RegisterFailureState({required this.message});
// }
// final class VerifyLoadingState extends AuthState {}
// final class VerifySuccessState extends AuthState {
//   final String message;
//   VerifySuccessState({required this.message});
// }
// final class VerifyFailureState extends AuthState {
//   final String message;
//   VerifyFailureState({required this.message});
// }
// final class ForgetPasswordLoadingState extends AuthState {}
// final class ForgetPasswordSuccessState extends AuthState {
//   final String message;
//   ForgetPasswordSuccessState({required this.message});
// }
// final class ForgetPasswordFailureState extends AuthState {
//   final String message;
//   ForgetPasswordFailureState({required this.message});
// }
// final class ResetPasswordLoadingState extends AuthState {}
// final class ResetPasswordSuccessState extends AuthState {
//   final String message;
//   ResetPasswordSuccessState({required this.message});
// }
// final class ResetPasswordFailureState extends AuthState {
//   final String message;
//   ResetPasswordFailureState({required this.message});
// }


class AuthStates extends Equatable {
  final AuthStateEnum? status;
  final String? message;
  final int? timer;

  const AuthStates({required this.status,this.message,this.timer});

  AuthStates copyWith({AuthStateEnum? status,String? message,int? timer}) {
    return AuthStates(message: message,status:status,timer: timer );
  }

  // Add below code
  @override
  List<Object?> get props => [message,status,timer];
}

enum AuthStateEnum{
  initial ,
  loading,
  loaded,fail
}