import 'package:flutter/foundation.dart';
import 'package:driver_application/features/home/data/models/shipments_response_model.dart';

@immutable
abstract class AvailableShipmentsState {}

class AvailableShipmentsInitial extends AvailableShipmentsState {}

class AvailableShipmentsLoading extends AvailableShipmentsState {}

class AvailableShipmentsSuccess extends AvailableShipmentsState {
  final List<Shipment> shipments;

  AvailableShipmentsSuccess({required this.shipments});
}

class AvailableShipmentsFailure extends AvailableShipmentsState {
  final String errMessage;

  AvailableShipmentsFailure({required this.errMessage});
}

class AvailableShipmentsPaginationLoading extends AvailableShipmentsState {
  final List<Shipment> shipments;

  AvailableShipmentsPaginationLoading({required this.shipments});
}

class AvailableShipmentsPaginationFailure extends AvailableShipmentsState {
  final String errMessage;
  final List<Shipment> shipments;

  AvailableShipmentsPaginationFailure({
    required this.errMessage,
    required this.shipments,
  });
}
