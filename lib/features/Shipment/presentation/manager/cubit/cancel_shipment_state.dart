abstract class CancelShipmentState {}

class CancelShipmentInitial extends CancelShipmentState {}

class CancelShipmentLoading extends CancelShipmentState {}

class CancelShipmentSuccess extends CancelShipmentState {}

class CancelShipmentFailure extends CancelShipmentState {
  final String errMessage;

  CancelShipmentFailure(this.errMessage);
}
