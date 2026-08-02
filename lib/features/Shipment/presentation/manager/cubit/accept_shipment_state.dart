import 'package:driver_application/features/Shipment/data/models/accept_shipment_response_model.dart';

abstract class AcceptShipmentState {}

class AcceptShipmentInitial extends AcceptShipmentState {}

class AcceptShipmentLoading extends AcceptShipmentState {}

class AcceptShipmentSuccess extends AcceptShipmentState {
  final AcceptShipmentResponseModel responseModel;

  AcceptShipmentSuccess(this.responseModel);
}

class AcceptShipmentFailure extends AcceptShipmentState {
  final String errMessage;

  AcceptShipmentFailure(this.errMessage);
}
