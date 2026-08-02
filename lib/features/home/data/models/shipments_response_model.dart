class ShipmentsResponseModel {
  final String status;
  final String message;
  final ShipmentsData data;

  const ShipmentsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ShipmentsResponseModel.fromJson(Map<String, dynamic> json) {
    return ShipmentsResponseModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data: ShipmentsData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ShipmentsData {
  final List<Shipment> shipments;
  final Pagination pagination;

  const ShipmentsData({
    required this.shipments,
    required this.pagination,
  });

  factory ShipmentsData.fromJson(Map<String, dynamic> json) {
    return ShipmentsData(
      shipments: (json['shipments'] as List<dynamic>)
          .map((e) => Shipment.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipments': shipments.map((e) => e.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class Shipment {
  final int id;
  final String goodsType;
  final num weight;
  final String vehicleType;
  final String vehicleSize;
  final bool nightShipping;
  final String whoPays;
  final num price;
  final String? additionalDetails;
  final String status;
  final String? pickupAt;
  final String? pickedUpAt;
  final String? deliveredAt;
  final List<String> mediaUrls;
  final Merchant merchant;
  final DriverModel? driver;
  final RouteModel route;
  final String createdAt;

  const Shipment({
    required this.id,
    required this.goodsType,
    required this.weight,
    required this.vehicleType,
    required this.vehicleSize,
    required this.nightShipping,
    required this.whoPays,
    required this.price,
    this.additionalDetails,
    required this.status,
    this.pickupAt,
    this.pickedUpAt,
    this.deliveredAt,
    required this.mediaUrls,
    required this.merchant,
    this.driver,
    required this.route,
    required this.createdAt,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'] as int,
      goodsType: json['goods_type'] as String,
      weight: json['weight'] as num,
      vehicleType: json['vehicle_type'] as String,
      vehicleSize: json['vehicle_size'] as String,
      nightShipping: json['night_shipping'] as bool,
      whoPays: json['who_pays'] as String,
      price: json['price'] as num,
      additionalDetails: json['additional_details'] as String?,
      status: json['status'] as String,
      pickupAt: json['pickup_at'] as String?,
      pickedUpAt: json['picked_up_at'] as String?,
      deliveredAt: json['delivered_at'] as String?,
      mediaUrls: (json['media_urls'] as List<dynamic>).map((e) => e.toString()).toList(),
      merchant: Merchant.fromJson(json['merchant'] as Map<String, dynamic>),
      driver: json['driver'] != null ? DriverModel.fromJson(json['driver'] as Map<String, dynamic>) : null,
      route: RouteModel.fromJson(json['route'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'goods_type': goodsType,
      'weight': weight,
      'vehicle_type': vehicleType,
      'vehicle_size': vehicleSize,
      'night_shipping': nightShipping,
      'who_pays': whoPays,
      'price': price,
      'additional_details': additionalDetails,
      'status': status,
      'pickup_at': pickupAt,
      'picked_up_at': pickedUpAt,
      'delivered_at': deliveredAt,
      'media_urls': mediaUrls,
      'merchant': merchant.toJson(),
      'driver': driver?.toJson(),
      'route': route.toJson(),
      'created_at': createdAt,
    };
  }
}

class DriverModel {
  final int id;
  final int uid;
  final String fullName;
  final String? email;
  final String phoneNumber;
  final String? vehicleType;
  final String? vehicleSize;
  final num? currentLat;
  final num? currentLon;
  final String? profilePictureUrl;

  const DriverModel({
    required this.id,
    required this.uid,
    required this.fullName,
    this.email,
    required this.phoneNumber,
    this.vehicleType,
    this.vehicleSize,
    this.currentLat,
    this.currentLon,
    this.profilePictureUrl,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] as int,
      uid: json['uid'] as int,
      fullName: json['full_name'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String,
      vehicleType: json['vehicle_type'] as String?,
      vehicleSize: json['vehicle_size'] as String?,
      currentLat: json['current_lat'] as num?,
      currentLon: json['current_lon'] as num?,
      profilePictureUrl: json['profile_picture_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'vehicle_type': vehicleType,
      'vehicle_size': vehicleSize,
      'current_lat': currentLat,
      'current_lon': currentLon,
      'profile_picture_url': profilePictureUrl,
    };
  }
}

class Merchant {
  final int id;
  final int uid;
  final String fullName;
  final String? email;
  final String phoneNumber;
  final String? profilePictureUrl;
  final String? address;

  const Merchant({
    required this.id,
    required this.uid,
    required this.fullName,
    this.email,
    required this.phoneNumber,
    this.profilePictureUrl,
    this.address,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      id: json['id'] as int,
      uid: json['uid'] as int,
      fullName: json['full_name'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String,
      profilePictureUrl: json['profile_picture_url'] as String?,
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
      'address': address,
    };
  }
}

class RouteModel {
  final String overviewPolyline;
  final String pickupLat;
  final String pickupLon;
  final CheckpointDetails pickupCheckpointDetails;
  final String deliveryLat;
  final String deliveryLon;
  final CheckpointDetails deliveryCheckpointDetails;
  final num distance;
  final int durationMinutes;

  const RouteModel({
    required this.overviewPolyline,
    required this.pickupLat,
    required this.pickupLon,
    required this.pickupCheckpointDetails,
    required this.deliveryLat,
    required this.deliveryLon,
    required this.deliveryCheckpointDetails,
    required this.distance,
    required this.durationMinutes,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      overviewPolyline: json['overview_polyline'] as String,
      pickupLat: json['pickup_lat'] as String,
      pickupLon: json['pickup_lon'] as String,
      pickupCheckpointDetails: CheckpointDetails.fromJson(json['pickup_checkpoint_details'] as Map<String, dynamic>),
      deliveryLat: json['delivery_lat'] as String,
      deliveryLon: json['delivery_lon'] as String,
      deliveryCheckpointDetails: CheckpointDetails.fromJson(json['delivery_checkpoint_details'] as Map<String, dynamic>),
      distance: json['distance'] as num,
      durationMinutes: json['duration_minutes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'overview_polyline': overviewPolyline,
      'pickup_lat': pickupLat,
      'pickup_lon': pickupLon,
      'pickup_checkpoint_details': pickupCheckpointDetails.toJson(),
      'delivery_lat': deliveryLat,
      'delivery_lon': deliveryLon,
      'delivery_checkpoint_details': deliveryCheckpointDetails.toJson(),
      'distance': distance,
      'duration_minutes': durationMinutes,
    };
  }
}

class CheckpointDetails {
  final int id;
  final String supervisorName;
  final String supervisorPhoneNumber;
  final String address;
  final String street;
  final String buildingNumber;
  final String? notes;

  const CheckpointDetails({
    required this.id,
    required this.supervisorName,
    required this.supervisorPhoneNumber,
    required this.address,
    required this.street,
    required this.buildingNumber,
    this.notes,
  });

  factory CheckpointDetails.fromJson(Map<String, dynamic> json) {
    return CheckpointDetails(
      id: json['id'] as int,
      supervisorName: json['supervisor_name'] as String,
      supervisorPhoneNumber: json['supervisor_phone_number'] as String,
      address: json['address'] as String,
      street: json['street'] as String,
      buildingNumber: json['building_number'] as String,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'supervisor_name': supervisorName,
      'supervisor_phone_number': supervisorPhoneNumber,
      'address': address,
      'street': street,
      'building_number': buildingNumber,
      'notes': notes,
    };
  }
}

class Pagination {
  final int currentPage;
  final int perPage;
  final int lastPage;
  final int total;
  final bool hasMore;
  final String? next;
  final String? prev;

  const Pagination({
    required this.currentPage,
    required this.perPage,
    required this.lastPage,
    required this.total,
    required this.hasMore,
    this.next,
    this.prev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] as int,
      perPage: json['per_page'] as int,
      lastPage: json['last_page'] as int,
      total: json['total'] as int,
      hasMore: json['has_more'] as bool,
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
