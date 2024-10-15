import 'package:dartz/dartz.dart';
import 'package:smp/core/entities/general_entity.dart';
import 'package:smp/core/error/failures.dart';
import 'package:smp/features/auth/domain/repo/repo.dart';

class ResendCodeUseCase{
  final AuthRepo repo;
  ResendCodeUseCase({required this.repo});
  Future<Either<Failure, GeneralEntity>> call({required String email}) async {
    return await repo.resendCode(email: email);
  }}