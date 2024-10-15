import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smp/core/entities/general_entity.dart';
import 'package:smp/core/error/exceptions.dart';
import 'package:smp/core/error/failures.dart';
import 'package:smp/core/network/network_info.dart';
import 'package:smp/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:smp/features/auth/data/model/register_model.dart';
import 'package:smp/features/auth/domain/entity/login_entity.dart';
import 'package:smp/features/auth/domain/entity/register_entity.dart';
import 'package:smp/features/auth/domain/repo/repo.dart';
import 'package:smp/generated/locale_keys.g.dart';

class AuthRepoImpl extends AuthRepo{
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl({required this.networkInfo, required this.authRemoteDataSource});
  @override
  Future<Either<Failure, LoginEntity>> login({required String email, required String password}) async {
    final bool deviceConnected = await networkInfo.isConnected;
    if (deviceConnected) {
      try {
        final remoteData = await authRemoteDataSource.login(email: email,password: password);

        return Right(remoteData);
      } on ServerException catch(e) {
        return Left(
          ServerFailure(message: e.message),
        );
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register({required String name, required String userName, required String email, required String password}) async{
    final bool deviceConnected = await networkInfo.isConnected;
    if (deviceConnected) {
      try {
        final remoteData = await authRemoteDataSource.register(email: email,password: password,userName: userName,name: name);

        return Right(remoteData);
      } on ServerException catch(e){
        return Left(
          ServerFailure(message: e.message),
        );
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, GeneralEntity>> verify({required String otp}) async{
    final bool deviceConnected = await networkInfo.isConnected;
    if (deviceConnected) {
      try {
        final remoteData = await authRemoteDataSource.verify(otp: otp);

        return Right(remoteData);
      } on ServerException catch(e){
        return Left(
          ServerFailure(message: e.message),
        );
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, GeneralEntity>> forgetPassword({required String email})async {
    final bool deviceConnected = await networkInfo.isConnected;
    if (deviceConnected) {
      try {
        final remoteData = await authRemoteDataSource.forgetPassword(email: email);

        return Right(remoteData);
      } on ServerException catch(e){
        return Left(
          ServerFailure(message: e.message),
        );
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, GeneralEntity>> resetPassword({required String password, required String confirmPassword}) async{
    final bool deviceConnected = await networkInfo.isConnected;
    if (deviceConnected) {
      try {
        final remoteData = await authRemoteDataSource.resetPassword(password: password,confirmPassword: confirmPassword);

        return Right(remoteData);
      } on ServerException catch(e){
        return Left(
          ServerFailure(message: e.message),
        );
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, GeneralEntity>> resendCode({required String email}) async {
    final bool deviceConnected = await networkInfo.isConnected;
    if (deviceConnected) {
      try {
        final remoteData = await authRemoteDataSource.resendCode(email: email);

        return Right(remoteData);
      } on ServerException catch(e){
        return Left(
          ServerFailure(message: e.message),
        );
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  
}