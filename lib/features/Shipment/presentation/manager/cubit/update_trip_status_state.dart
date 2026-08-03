import 'package:driver_application/features/Shipment/data/models/change_shipment_status_response_model.dart';

abstract class UpdateTripStatusState {}

class UpdateTripStatusInitial extends UpdateTripStatusState {}

class UpdateTripStatusLoading extends UpdateTripStatusState {}

class UpdateTripStatusSuccess extends UpdateTripStatusState {
  final ChangeShipmentStatusResponseModel responseModel;

  UpdateTripStatusSuccess(this.responseModel);
}

class UpdateTripStatusFailure extends UpdateTripStatusState {
  final String errMessage;

  UpdateTripStatusFailure(this.errMessage);
}
