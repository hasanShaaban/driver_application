import 'package:driver_application/features/Shipment/domain/data_source/shipment_local_data_source.dart';
import 'package:driver_application/features/home/data/models/shipments_response_model.dart';
import 'package:driver_application/features/home/domain/repo/my_shipments_repo.dart';

class MyShipmentsRepoImpl implements MyShipmentsRepo {
  final ShipmentLocalDataSource shipmentLocalDataSource;

  MyShipmentsRepoImpl({required this.shipmentLocalDataSource});

  @override
  Future<Shipment?> getSavedShipment() {
    return shipmentLocalDataSource.getAcceptedShipment();
  }
}
