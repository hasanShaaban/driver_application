import 'package:driver_application/features/home/data/models/shipments_response_model.dart';

class AcceptShipmentResponseModel {
  final String status;
  final String message;
  final Shipment data;

  const AcceptShipmentResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AcceptShipmentResponseModel.fromJson(Map<String, dynamic> json) {
    return AcceptShipmentResponseModel(
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
