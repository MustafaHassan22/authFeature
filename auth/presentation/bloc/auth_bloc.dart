import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/features/auth/domain/usecase/forget_password_usecase.dart';
import 'package:smp/features/auth/domain/usecase/login_usecase.dart';
import 'package:smp/features/auth/domain/usecase/register_usecase.dart';
import 'package:smp/features/auth/domain/usecase/resend_code_usecase.dart';
import 'package:smp/features/auth/domain/usecase/reset_password_usecase.dart';
import 'package:smp/features/auth/domain/usecase/verify_usecase.dart';
import 'package:smp/features/auth/presentation/bloc/auth_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final otp = TextEditingController();
  bool isAgree = false;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final VerifyUseCase verifyUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final ResendCodeUseCase resendCodeUseCase;

  AuthBloc(
      {required this.loginUseCase,
      required this.registerUseCase,
      required this.verifyUseCase,
      required this.forgetPasswordUseCase,
      required this.resetPasswordUseCase,
      required this.resendCodeUseCase,
      })
      : super(const AuthStates(status: AuthStateEnum.initial)) {
    on<CountDownEvent>(countDown);
    on<LoginEvent>(login);
    on<RegisterEvent>(register);
    on<VerifyEvent>(verify);
    on<ForgetPasswordEvent>(forgetPassword);
    on<ResetPasswordEvent>(resetPassword);
    on<ResendCodeEvent>(resendCode);
  }

  FutureOr<void> countDown(
      CountDownEvent event, Emitter<AuthStates> emit) async {
    emit(const AuthStates(status: AuthStateEnum.loading,timer: 30));
    for (int i = 30; i >= 0; i--) {
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          emit(AuthStates(status: AuthStateEnum.loading,timer: i));
        },
      );
    }
    emit(const AuthStates(status: AuthStateEnum.loaded));
  }

  FutureOr<void> login(LoginEvent event, Emitter<AuthStates> emit) async {
    emit(const AuthStates(status: AuthStateEnum.loading));
    final response =
        await loginUseCase.call(email: event.email, password: event.password);
    response.fold((failure) {
      emit(AuthStates(status: AuthStateEnum.fail,message: failure.message));
    }, (success) {
      emit(AuthStates(status: AuthStateEnum.loaded,message: success.message));
    });
  }

  FutureOr<void> register(RegisterEvent event, Emitter<AuthStates> emit) async {
    emit(const AuthStates(status: AuthStateEnum.loading));
    final response = await registerUseCase.call(
        email: event.email,
        password: event.password,
        name: event.name,
        userName: event.userName);
    response.fold((failure) {
      print(failure);
      emit(AuthStates(status: AuthStateEnum.fail,message: failure.message));
    }, (success) {
      emit(AuthStates(status: AuthStateEnum.loaded,message: '${success.message} ${success.otp}'));
    });
  }

  FutureOr<void> verify(VerifyEvent event, Emitter<AuthStates> emit) async {
    emit(const AuthStates(status: AuthStateEnum.loading));
    final response = await verifyUseCase.call(otp: event.otp);
    response.fold((failure) {
      emit(AuthStates(status: AuthStateEnum.fail,message: failure.message));
    }, (success) {
      emit(AuthStates(status: AuthStateEnum.loaded,message: success.message));
    });
  }

  FutureOr<void> forgetPassword(
      ForgetPasswordEvent event, Emitter<AuthStates> emit) async {
    emit(const AuthStates(status: AuthStateEnum.loading));
    final response = await forgetPasswordUseCase.call(email: event.email);
    response.fold((failure) {
      emit(AuthStates(status: AuthStateEnum.fail,message: failure.message));
    }, (success) {
      emit(AuthStates(status: AuthStateEnum.loaded,message: success.message));
    });
  }

  FutureOr<void> resetPassword(
      ResetPasswordEvent event, Emitter<AuthStates> emit) async {
    emit(const AuthStates(status: AuthStateEnum.loading));
    final response = await resetPasswordUseCase.call(
        password: event.password, confirmPassword: event.confirmPassword);
    response.fold((failure) {
      emit(AuthStates(status: AuthStateEnum.fail,message: failure.message));
    }, (success) {
      emit(AuthStates(status: AuthStateEnum.loaded, message: success.message));
    });
  }

  FutureOr<void> resendCode(
      ResendCodeEvent event, Emitter<AuthStates> emit) async {
    emit(const AuthStates(status: AuthStateEnum.loading));
    final response = await resendCodeUseCase.call(email: event.email);
    response.fold((failure) {
      emit(AuthStates(status: AuthStateEnum.fail,message: failure.message));
    }, (success) {
      emit(AuthStates(status: AuthStateEnum.loaded,message: success.message));
    });
  }
}
