import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:driver_application/core/utils/service_locator.dart';
import 'package:driver_application/features/Shipment/data/models/route_info.dart';
import 'package:driver_application/features/Shipment/domain/repo/order_repo.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/get_route_cubit.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/get_route_state.dart';

class MapView extends StatefulWidget {
  const MapView({
    super.key,
    required this.id,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.initialLocation,
  });
  final int id;
  final String pickupLat;
  final String pickupLng;
  final String destinationLat;
  final String destinationLng;
  final String initialLocation;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final LatLng pickup;
  late final LatLng destination;
  late final Marker pickupMarker;
  late final Marker destinationMarker;
  late LatLng currentLocation;
  GoogleMapController? _controller;
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    pickup = LatLng(
      double.parse(widget.pickupLat),
      double.parse(widget.pickupLng),
    );
    destination = LatLng(
      double.parse(widget.destinationLat),
      double.parse(widget.destinationLng),
    );
    pickupMarker = Marker(
      markerId: MarkerId('pickup'),
      position: pickup,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    destinationMarker = Marker(
      markerId: MarkerId('destination'),
      position: destination,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    setInitialLocation();
  }

  void setInitialLocation() {
    if (widget.initialLocation == 'pickup') {
      currentLocation = pickup;
    } else {
      currentLocation = destination;
    }
  }

  Future<void> _moveCamera(LatLng target) async {
    await _controller?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: target, zoom: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetRouteCubit(getIt.get<OrderRepo>())
        ..getRoute(
          start: LatLngPoint(pickup.latitude, pickup.longitude),
          end: LatLngPoint(destination.latitude, destination.longitude),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'طلب رقم ${widget.id}',
            style: AppTextStyle.medium16.copyWith(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),
        body: BlocConsumer<GetRouteCubit, GetRouteState>(
          listener: (context, state) {
            if (state is GetRouteSuccess) {
              setState(() {
                _polylines.add(
                  Polyline(
                    polylineId: const PolylineId('route'),
                    color: AppColors.primaryColor,
                    width: 5,
                    points: state.routeInfo.points
                        .map((e) => LatLng(e.lat, e.lng))
                        .toList(),
                  ),
                );
              });
            } else if (state is GetRouteFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) => _controller = controller,
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                    zoom: 16,
                  ),
                  markers: {pickupMarker, destinationMarker},
                  polylines: _polylines,
                  markerType: GoogleMapMarkerType.advancedMarker,
                ),
                Positioned(
                  bottom: 100,
                  right: 75,
                  left: 75,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () async {
                      if (currentLocation == pickup) {
                        currentLocation = destination;
                      } else {
                        currentLocation = pickup;
                      }
                      await _moveCamera(currentLocation);
                      setState(() {});
                    },
                    child: Text(
                      'اذهب إلى موقع ${currentLocation == pickup ? 'التنزيل' : 'التحميل'}',
                      style: AppTextStyle.medium16.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                if (state is GetRouteLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
