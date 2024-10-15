import 'package:dartz/dartz.dart';
import 'package:smp/core/entities/general_entity.dart';
import 'package:smp/core/error/failures.dart';
import 'package:smp/features/auth/domain/entity/login_entity.dart';
import 'package:smp/features/auth/domain/entity/register_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginEntity>> login(
      {required String email, required String password});
  Future<Either<Failure, RegisterEntity>> register(
      {required String name,
      required String userName,
      required String email,
      required String password});
  Future<Either<Failure, GeneralEntity>> verify({required String otp});
  Future<Either<Failure, GeneralEntity>> forgetPassword(
      {required String email});
  Future<Either<Failure, GeneralEntity>> resetPassword(
      {required String password, required String confirmPassword});
  Future<Either<Failure, GeneralEntity>> resendCode({required String email});
}
