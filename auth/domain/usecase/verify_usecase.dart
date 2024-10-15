import 'package:dartz/dartz.dart';
import 'package:smp/core/entities/general_entity.dart';
import 'package:smp/core/error/failures.dart';
import 'package:smp/features/auth/domain/entity/register_entity.dart';
import 'package:smp/features/auth/domain/repo/repo.dart';

class VerifyUseCase{
  final AuthRepo repo;
  VerifyUseCase({required this.repo});
  Future<Either<Failure, GeneralEntity>> call({required String otp}) async {
    return await repo.verify(otp: otp);
  }}