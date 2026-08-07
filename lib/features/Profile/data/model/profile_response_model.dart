import 'ratings_response_model.dart';

class ProfileResponseModel {
  final ProfileDataModel? data;

  const ProfileResponseModel({
    this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      data: json['data'] != null ? ProfileDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class ProfileDataModel {
  final int? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final DriverProfileModel? driverProfile;

  const ProfileDataModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.profilePictureUrl,
    this.driverProfile,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      id: json['id'] as int?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      driverProfile: json['driver_profile'] != null
          ? DriverProfileModel.fromJson(json['driver_profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'profile_picture_url': profilePictureUrl,
      'driver_profile': driverProfile?.toJson(),
    };
  }
}
