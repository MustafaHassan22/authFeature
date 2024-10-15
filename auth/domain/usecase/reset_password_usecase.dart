import 'package:dartz/dartz.dart';
import 'package:smp/core/entities/general_entity.dart';
import 'package:smp/core/error/failures.dart';
import 'package:smp/features/auth/domain/repo/repo.dart';

class ResetPasswordUseCase{
  final AuthRepo repo;
  ResetPasswordUseCase({required this.repo});
  Future<Either<Failure, GeneralEntity>> call({required String password,required String confirmPassword}) async {
    return await repo.resetPassword(password: password,confirmPassword: confirmPassword);
  }}