import 'package:driver_application/features/home/data/models/shipments_response_model.dart';

class ChangeShipmentStatusResponseModel {
  final String status;
  final String message;
  final Shipment data;

  const ChangeShipmentStatusResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChangeShipmentStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangeShipmentStatusResponseModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data: Shipment.fromJson(json['data'] as Map<String, dynamic>),
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
