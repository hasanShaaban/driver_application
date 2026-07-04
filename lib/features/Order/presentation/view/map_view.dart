import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    return Scaffold(
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(backgroundColor: AppColors.primaryColor),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          'طلب رقم ${widget.id}',
          style: AppTextStyle.medium16.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: GoogleMap(
        onMapCreated: (controller) => _controller = controller,
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 16,
        ),
        markers: {pickupMarker, destinationMarker},
        markerType: GoogleMapMarkerType.advancedMarker,
      ),
    );
  }
}
