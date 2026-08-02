import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/service_locator.dart';
import 'package:driver_application/features/home/domain/repo/my_shipments_repo.dart';
import 'package:driver_application/features/home/presentation/manager/my_shipments_cubit/my_shipments_cubit.dart';
import 'package:driver_application/features/home/presentation/manager/my_shipments_cubit/my_shipments_state.dart';
import 'package:driver_application/features/home/presentation/view/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyShipmentsCubit(getIt.get<MyShipmentsRepo>())..fetchSavedShipment(),
      child: MyShipmentColumn(),
    );
  }
}

class MyShipmentColumn extends StatelessWidget {
  const MyShipmentColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 21),
        BlocBuilder<MyShipmentsCubit, MyShipmentsState>(
          builder: (context, state) {
            if (state is MyShipmentsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyShipmentsSuccess) {
              if (state.shipment != null) {
                return OrderCard(
                  shipment: state.shipment!,
                  colors: [
                    AppColors.successColor.withValues(alpha: 0.4),
                    Colors.green,
                    Colors.greenAccent,
                  ],
                );
              } else {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'لا توجد رحلات مقبولة حالياً',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }
            } else if (state is MyShipmentsFailure) {
              return Center(child: Text(state.errMessage));
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
