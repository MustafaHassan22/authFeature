import 'package:dartz/dartz.dart';
import 'package:smp/core/error/failures.dart';
import 'package:smp/features/auth/domain/entity/register_entity.dart';
import 'package:smp/features/auth/domain/repo/repo.dart';

class RegisterUseCase{
  final AuthRepo repo;
  RegisterUseCase({required this.repo});
  Future<Either<Failure, RegisterEntity>> call({required String name,required String userName,required String email,required String password}) async {
    return await repo.register(email: email,password: password,name: name,userName: userName);
  }}