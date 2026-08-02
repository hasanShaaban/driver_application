class RouteInfo {
  final List<LatLngPoint> points;
  final double distanceMeters;
  final double durationSeconds;

  const RouteInfo({
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
  });
}

class LatLngPoint {
  final double lat;
  final double lng;
  const LatLngPoint(this.lat, this.lng);
}
