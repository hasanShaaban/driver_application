import 'package:driver_application/features/Order/data/models/route_info.dart';

abstract class GetRouteState {}

class GetRouteInitial extends GetRouteState {}

class GetRouteLoading extends GetRouteState {}

class GetRouteSuccess extends GetRouteState {
  final RouteInfo routeInfo;

  GetRouteSuccess(this.routeInfo);
}

class GetRouteFailure extends GetRouteState {
  final String errorMessage;

  GetRouteFailure(this.errorMessage);
}
