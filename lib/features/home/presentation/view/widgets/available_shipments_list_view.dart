import 'package:driver_application/features/home/presentation/view/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/available_shipments_cubit/available_shipments_cubit.dart'
    show AvailableShipmentsCubit;
import '../../manager/available_shipments_cubit/available_shipments_state.dart';

class AvailableShipmentsListView extends StatelessWidget {
  const AvailableShipmentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableShipmentsCubit, AvailableShipmentsState>(
      builder: (context, state) {
        if (state is AvailableShipmentsFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is AvailableShipmentsSuccess ||
            state is AvailableShipmentsPaginationLoading ||
            state is AvailableShipmentsPaginationFailure) {
          List shipments = [];
          if (state is AvailableShipmentsSuccess) shipments = state.shipments;
          if (state is AvailableShipmentsPaginationLoading)
            shipments = state.shipments;
          if (state is AvailableShipmentsPaginationFailure)
            shipments = state.shipments;

          return Expanded(
            child: ListView.separated(
              controller: context
                  .read<AvailableShipmentsCubit>()
                  .scrollController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < shipments.length) {
                  return const OrderCard();
                } else {
                  if (state is AvailableShipmentsPaginationLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is AvailableShipmentsPaginationFailure) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: Text(state.errMessage)),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
              itemCount:
                  shipments.length +
                  (state is AvailableShipmentsPaginationLoading ||
                          state is AvailableShipmentsPaginationFailure
                      ? 1
                      : 0),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
