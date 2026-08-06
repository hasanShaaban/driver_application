import 'dart:async';
import 'dart:developer';
import 'package:driver_application/features/Shipment/domain/repo/shipment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'update_location_state.dart';

class UpdateLocationCubit extends Cubit<UpdateLocationState> {
  UpdateLocationCubit(this.orderRepo) : super(UpdateLocationInitial());

  final OrderRepo orderRepo;
  Timer? _timer;

  /// Starts periodic location updates every 10 seconds if conditions are met:
  /// 1. User has accepted the opened shipment ([isTakenByMe] is true)
  /// 2. Status of shipment is not 'scheduled', 'delivered', or 'completed'
  void startLocationTracking({
    required bool isTakenByMe,
    required String status,
  }) {
    stopLocationTracking();

    final String normalizedStatus = status.toLowerCase().trim();

    if (!isTakenByMe ||
        normalizedStatus == 'scheduled' ||
        normalizedStatus == 'delivered' ||
        normalizedStatus == 'completed') {
      return;
    }
    log('Start Tracking location');
    _sendLocationUpdate();

    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _sendLocationUpdate();
    });
  }

  Future<void> _sendLocationUpdate() async {
    try {
      log('get current location');
      final userLocation = await orderRepo.getCurrentLocation();
      log(
        'got current location ${userLocation.latitude} ${userLocation.longitude}',
      );

      log('update location');
      final result = await orderRepo.updateLocation(
        lat: userLocation.latitude,
        lng: userLocation.longitude,
      );

      if (isClosed) return;

      result.fold(
        (failure) => emit(UpdateLocationFailure(failure.message)),
        (success) => emit(UpdateLocationSuccess(success)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(UpdateLocationFailure(e.toString()));
    }
  }

  void stopLocationTracking() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    stopLocationTracking();
    return super.close();
  }
}
