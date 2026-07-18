import 'package:driver_application/features/Order/data/models/route_info.dart';
import 'package:driver_application/features/Order/domain/repo/order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'get_route_state.dart';

class GetRouteCubit extends Cubit<GetRouteState> {
  GetRouteCubit(this.orderRepo) : super(GetRouteInitial());

  final OrderRepo orderRepo;

  Future<void> getRoute({
    required LatLngPoint start,
    required LatLngPoint end,
  }) async {
    emit(GetRouteLoading());
    var result = await orderRepo.getRoute(start: start, end: end);
    result.fold(
      (failure) => emit(GetRouteFailure(failure.message)),
      (routeInfo) => emit(GetRouteSuccess(routeInfo)),
    );
  }
}
