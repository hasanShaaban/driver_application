import 'package:driver_application/features/home/data/models/shipments_response_model.dart';

abstract class ShipmentLocalDataSource {
  Future<void> saveAcceptedShipment({required Shipment shipment});
  Future<Shipment?> getAcceptedShipment();
  Future<void> deleteAcceptedShipment();
}
