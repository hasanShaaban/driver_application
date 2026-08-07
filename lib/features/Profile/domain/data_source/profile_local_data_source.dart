import 'package:driver_application/features/Profile/data/model/profile_response_model.dart';

abstract class ProfileLocalDataSource {
  Future<void> saveProfileData(ProfileResponseModel profileModel);
  ProfileResponseModel? getProfileData();
  
  Future<void> saveProfileVisitCount(int count);
  int getProfileVisitCount();
}
