import 'package:dartz/dartz.dart';
import 'package:smp/core/error/failures.dart';
import 'package:smp/features/auth/domain/entity/login_entity.dart';
import 'package:smp/features/auth/domain/repo/repo.dart';

class LoginUseCase{
  final AuthRepo repo;
  LoginUseCase({required this.repo});
  Future<Either<Failure, LoginEntity>> call({required String email,required String password}) async {
    return await repo.login(email: email,password: password);
  }}