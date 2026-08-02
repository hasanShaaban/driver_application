import 'dart:convert';
import 'dart:developer';
import 'package:driver_application/core/storage/app_storage.dart';
import 'package:driver_application/features/Shipment/domain/data_source/shipment_local_data_source.dart';
import 'package:driver_application/features/home/data/models/shipments_response_model.dart';

class ShipmentLocalDataSourceImpl implements ShipmentLocalDataSource {
  final AppStorage appStorage;
  static const String kAcceptedShipmentKey = 'accepted_shipment';

  ShipmentLocalDataSourceImpl({required this.appStorage});

  @override
  Future<void> saveAcceptedShipment({required Shipment shipment}) async {
    final jsonData = jsonEncode(shipment.toJson());
    log('saveAcceptedShipment data: \n$jsonData');
    await appStorage.write(key: kAcceptedShipmentKey, value: jsonData);
  }

  @override
  Future<Shipment?> getAcceptedShipment() async {
    final data = appStorage.read(key: kAcceptedShipmentKey);
    if (data != null && data is String) {
      return Shipment.fromJson(jsonDecode(data) as Map<String, dynamic>);
    }
    log('getAcceptedShipment data: ${data.toString()}');
    return null;
  }

  @override
  Future<void> deleteAcceptedShipment() async {
    await appStorage.delete(key: kAcceptedShipmentKey);
  }
}
