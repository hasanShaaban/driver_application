import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_application/features/home/domain/repo/home_repo.dart';
import 'package:driver_application/features/home/data/models/shipments_response_model.dart';
import 'available_shipments_state.dart';

class AvailableShipmentsCubit extends Cubit<AvailableShipmentsState> {
  final HomeRepo homeRepo;

  AvailableShipmentsCubit(this.homeRepo) : super(AvailableShipmentsInitial()) {
    scrollController.addListener(_scrollListener);
  }

  final ScrollController scrollController = ScrollController();

  int _currentPage = 1;
  bool _hasMore = true;
  final List<Shipment> _shipments = [];
  bool _isLoading = false;

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.7) {
      if (!_isLoading && _hasMore) {
        fetchAvailableShipments(loadMore: true);
      }
    }
  }

  Future<void> fetchAvailableShipments({bool loadMore = false}) async {
    if (_isLoading) return;

    if (loadMore) {
      if (!_hasMore) return;
      _isLoading = true;
      emit(AvailableShipmentsPaginationLoading(shipments: List.from(_shipments)));
    } else {
      _currentPage = 1;
      _hasMore = true;
      _shipments.clear();
      _isLoading = true;
      emit(AvailableShipmentsLoading());
    }

    var result = await homeRepo.getAllShipments(page: _currentPage);

    result.fold(
      (failure) {
        _isLoading = false;
        if (loadMore) {
          emit(AvailableShipmentsPaginationFailure(
            errMessage: failure.message,
            shipments: List.from(_shipments),
          ));
        } else {
          emit(AvailableShipmentsFailure(errMessage: failure.message));
        }
      },
      (response) {
        _isLoading = false;
        _currentPage++;
        _hasMore = response.data.pagination.hasMore;
        _shipments.addAll(response.data.shipments);
        emit(AvailableShipmentsSuccess(shipments: List.from(_shipments)));
      },
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
