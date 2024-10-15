import 'package:smp/core/api/client.dart';
import 'package:smp/core/api/end_points.dart';
import 'package:smp/core/entities/general_entity.dart';
import 'package:smp/core/error/exceptions.dart';
import 'package:smp/core/models/general_model.dart';
import 'package:smp/core/shared_pref.dart';
import 'package:smp/features/auth/data/model/login_model.dart';
import 'package:smp/features/auth/data/model/register_model.dart';
import 'package:smp/features/auth/domain/entity/login_entity.dart';
import 'package:smp/features/auth/domain/entity/register_entity.dart';

abstract class AuthRemoteDataSource{
  Future<LoginEntity> login({required String email,required String password});
  Future<RegisterEntity> register({required String name,required String userName,required String email,required String password});
  Future<GeneralEntity> verify({required String otp});
  Future<GeneralEntity> forgetPassword({required String email});
  Future<GeneralEntity> resetPassword({required String password,required String confirmPassword});
  Future<GeneralEntity> resendCode({required String email});
}
class AuthRemoteDataSourceImp extends AuthRemoteDataSource{
  final ClientServices client;
  AuthRemoteDataSourceImp({required this.client});
  @override
  Future<LoginEntity> login({required String email, required String password}) async {
    final response = await client.postCallService(
      url: Urls.login,
      requestBody: {
        'email':email,
        'password':password
      },
    );
    print(response);
    if (response!.statusCode == 200) {
      final LoginEntity loginResponse = LoginModel.fromJson(response.data);
      SharedPrefs.saveToken(loginResponse.token);
      SharedPrefs.saveId(loginResponse.user.id);
      SharedPrefs.saveFName(loginResponse.user.name);
      SharedPrefs.saveIsLogin(true);
      SharedPrefs.savePhone(loginResponse.user.phoneNumber??'');
      SharedPrefs.saveEmail(loginResponse.user.email);
      SharedPrefs.saveImage(loginResponse.user.profilePicture);
      SharedPrefs.saveCover(loginResponse.user.cover);
      return loginResponse;
    } else {
      throw ServerException(
        message: response.data['message'],
      );
    }
  }

  @override
  Future<RegisterEntity> register({required String name,required String userName,required String email,required String password}) async {
    final response = await client.postCallService(
      url: Urls.register,
      requestBody: {
        'name':name,
        'username':userName,
        'email':email,
        'password':password
      },
    );
    print(response);
    if (response!.statusCode == 200) {
      final RegisterEntity registerModel = RegisterModel.fromJson(response.data);
      // SharedPrefs.saveToken(loginResponse.token);
      // SharedPrefs.saveId(loginResponse.user.id);
      // SharedPrefs.saveFName(loginResponse.user.name);
      // SharedPrefs.saveEmail(loginResponse.user.email);
      return registerModel;
    } else {
      throw ServerException(
        message: response.data['message'],
      );
    }
  }

  @override
  Future<GeneralEntity> verify({required String otp}) async{
    final response = await client.postCallService(
      url: Urls.verify,
      requestBody: {
        'otp':otp,
      },
    );
    print(response);
    if (response!.statusCode == 200) {
      SharedPrefs.saveToken(response.data['token']);
      return GeneralModel(message: response.data['message']);
    } else {
      throw ServerException(
        message: response.data['message'],
      );
    }
  }

  @override
  Future<GeneralEntity> forgetPassword({required String email}) async{
    final response = await client.postCallService(
      url: Urls.forgetPassword,
      requestBody: {
        'email':email,
      },
    );
    print(response);
    if (response!.statusCode == 200) {
      SharedPrefs.saveToken(response.data['token']);
      return GeneralModel(message: response.data['message']+"${response.data['otp']}");
    } else {
      throw ServerException(
        message: response.data['message'],
      );
    }
  }

  @override
  Future<GeneralEntity> resetPassword({required String password,required String confirmPassword}) async{
    final response = await client.postCallService(
      url: Urls.resetPassword,
      requestBody: {
        'password':password,
        'password_confirmation':confirmPassword,
      },
    );
    print(response);
    if (response!.statusCode == 200) {
      return GeneralModel(message: response.data['message']);
    } else {
      throw ServerException(
        message: response.data['message'],
      );
    }
  }

  @override
  Future<GeneralEntity> resendCode({required String email}) async {
    final response = await client.postCallService(
      url: Urls.resendCode,
      requestBody: {
        'email':email,
      },
    );
    if (response!.statusCode == 200) {
      SharedPrefs.saveToken(response.data['token']);
      return GeneralModel(message: response.data['message']+"${response.data['otp']}");
    } else {
      throw ServerException(
        message: response.data['message'],
      );
    }
  }

}