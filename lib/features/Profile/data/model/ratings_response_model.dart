class RatingsResponseModel {
  final String? status;
  final String? message;
  final RatingsData? data;

  const RatingsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory RatingsResponseModel.fromJson(Map<String, dynamic> json) {
    return RatingsResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null ? RatingsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class RatingsData {
  final List<RatingModel>? ratings;
  final PaginationModel? pagination;

  const RatingsData({
    this.ratings,
    this.pagination,
  });

  factory RatingsData.fromJson(Map<String, dynamic> json) {
    return RatingsData(
      ratings: json['ratings'] != null
          ? (json['ratings'] as List).map((i) => RatingModel.fromJson(i)).toList()
          : null,
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ratings': ratings?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class RatingModel {
  final RatingUserModel? ratee;
  final RatingUserModel? rater;
  final int? shipmentId;
  final int? rating;
  final String? comment;
  final String? createdAt;

  const RatingModel({
    this.ratee,
    this.rater,
    this.shipmentId,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      ratee: json['ratee'] != null ? RatingUserModel.fromJson(json['ratee']) : null,
      rater: json['rater'] != null ? RatingUserModel.fromJson(json['rater']) : null,
      shipmentId: json['shipment_id'] as int?,
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ratee': ratee?.toJson(),
      'rater': rater?.toJson(),
      'shipment_id': shipmentId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
    };
  }
}

class RatingUserModel {
  final int? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final DriverProfileModel? driverProfile;
  final MerchantProfileModel? merchantProfile;

  const RatingUserModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.driverProfile,
    this.merchantProfile,
  });

  factory RatingUserModel.fromJson(Map<String, dynamic> json) {
    return RatingUserModel(
      id: json['id'] as int?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      driverProfile: json['driver_profile'] != null
          ? DriverProfileModel.fromJson(json['driver_profile'])
          : null,
      merchantProfile: json['merchant_profile'] != null
          ? MerchantProfileModel.fromJson(json['merchant_profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'driver_profile': driverProfile?.toJson(),
      'merchant_profile': merchantProfile?.toJson(),
    };
  }
}

class DriverProfileModel {
  final int? id;
  final int? uid;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final int? age;
  final String? gender;
  final String? vehicleType;
  final String? vehicleSize;
  final int? vehicleCapacityKg;
  final String? licensePlateNumber;
  final RatingInfoModel? ratingInfo;
  final String? description;

  const DriverProfileModel({
    this.id,
    this.uid,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.profilePictureUrl,
    this.age,
    this.gender,
    this.vehicleType,
    this.vehicleSize,
    this.vehicleCapacityKg,
    this.licensePlateNumber,
    this.ratingInfo,
    this.description,
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      id: json['id'] as int?,
      uid: json['uid'] as int?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      vehicleType: json['vehicle_type'] as String?,
      vehicleSize: json['vehicle_size'] as String?,
      vehicleCapacityKg: json['vehicle_capacity_kg'] as int?,
      licensePlateNumber: json['license_plate_number'] as String?,
      ratingInfo: json['rating_info'] != null
          ? RatingInfoModel.fromJson(json['rating_info'])
          : null,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'profile_picture_url': profilePictureUrl,
      'age': age,
      'gender': gender,
      'vehicle_type': vehicleType,
      'vehicle_size': vehicleSize,
      'vehicle_capacity_kg': vehicleCapacityKg,
      'license_plate_number': licensePlateNumber,
      'rating_info': ratingInfo?.toJson(),
      'description': description,
    };
  }
}

class MerchantProfileModel {
  final int? id;
  final int? uid;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final String? commercialRegistrationNumber;
  final String? idCardNumber;
  final RatingInfoModel? ratingInfo;
  final String? address;

  const MerchantProfileModel({
    this.id,
    this.uid,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.profilePictureUrl,
    this.commercialRegistrationNumber,
    this.idCardNumber,
    this.ratingInfo,
    this.address,
  });

  factory MerchantProfileModel.fromJson(Map<String, dynamic> json) {
    return MerchantProfileModel(
      id: json['id'] as int?,
      uid: json['uid'] as int?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      commercialRegistrationNumber: json['commercial_registration_number'] as String?,
      idCardNumber: json['id_card_number'] as String?,
      ratingInfo: json['rating_info'] != null
          ? RatingInfoModel.fromJson(json['rating_info'])
          : null,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'profile_picture_url': profilePictureUrl,
      'commercial_registration_number': commercialRegistrationNumber,
      'id_card_number': idCardNumber,
      'rating_info': ratingInfo?.toJson(),
      'address': address,
    };
  }
}

class RatingInfoModel {
  final String? averageRating;
  final int? totalRatings;

  const RatingInfoModel({
    this.averageRating,
    this.totalRatings,
  });

  factory RatingInfoModel.fromJson(Map<String, dynamic> json) {
    return RatingInfoModel(
      averageRating: json['average_rating'] as String?,
      totalRatings: json['total_ratings'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average_rating': averageRating,
      'total_ratings': totalRatings,
    };
  }
}

class PaginationModel {
  final int? currentPage;
  final int? perPage;
  final int? lastPage;
  final int? total;
  final bool? hasMore;
  final String? next;
  final String? prev;

  const PaginationModel({
    this.currentPage,
    this.perPage,
    this.lastPage,
    this.total,
    this.hasMore,
    this.next,
    this.prev,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] as int?,
      perPage: json['per_page'] as int?,
      lastPage: json['last_page'] as int?,
      total: json['total'] as int?,
      hasMore: json['has_more'] as bool?,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'last_page': lastPage,
      'total': total,
      'has_more': hasMore,
      'next': next,
      'prev': prev,
    };
  }
}
