import 'package:driver_application/features/home/data/models/shipments_response_model.dart';

abstract class MyShipmentsRepo {
  Future<Shipment?> getSavedShipment();
}
