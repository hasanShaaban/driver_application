import 'dart:convert';
import 'package:driver_application/core/storage/app_storage.dart';
import 'package:driver_application/features/Auth/data/models/login_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveLoginData(LoginModel loginModel);
  LoginModel? getLoginData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AppStorage appStorage;
  static const String _loginDataKey = 'login_data_key';

  AuthLocalDataSourceImpl({required this.appStorage});

  @override
  Future<void> saveLoginData(LoginModel loginModel) async {
    final jsonData = jsonEncode(loginModel.toJson());
    await appStorage.write(key: _loginDataKey, value: jsonData);
  }

  @override
  LoginModel? getLoginData() {
    final data = appStorage.read(key: _loginDataKey);
    if (data != null && data is String) {
      return LoginModel.fromJson(jsonDecode(data));
    }
    return null;
  }
}
