import 'dart:convert';

import 'package:driver_application/core/storage/app_storage.dart';
import 'package:driver_application/features/Profile/data/model/profile_response_model.dart';
import 'package:driver_application/features/Profile/domain/data_source/profile_local_data_source.dart';

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final AppStorage appStorage;
  static const String _profileDataKey = 'profile_data_key';

  ProfileLocalDataSourceImpl({required this.appStorage});

  @override
  Future<void> saveProfileData(ProfileResponseModel profileModel) async {
    final jsonData = jsonEncode(profileModel.toJson());
    await appStorage.write(key: _profileDataKey, value: jsonData);
  }

  @override
  ProfileResponseModel? getProfileData() {
    final data = appStorage.read(key: _profileDataKey);
    if (data != null && data is String) {
      return ProfileResponseModel.fromJson(jsonDecode(data));
    }
    return null;
  }

  static const String _profileVisitCountKey = 'profile_visit_count_key';

  @override
  Future<void> saveProfileVisitCount(int count) async {
    await appStorage.write(key: _profileVisitCountKey, value: count.toString());
  }

  @override
  int getProfileVisitCount() {
    final count = appStorage.read(key: _profileVisitCountKey);
    if (count != null && count is String) {
      return int.tryParse(count) ?? 0;
    }
    return 0;
  }
}
