import 'package:driver_application/core/utils/service_locator.dart';
import 'package:driver_application/features/home/domain/repo/home_repo.dart';
import 'package:driver_application/features/home/presentation/manager/available_shipments_cubit/available_shipments_cubit.dart';
import 'package:driver_application/features/home/presentation/view/widgets/available_shipments_list_view.dart';
import 'package:driver_application/features/home/presentation/view/widgets/refresh_button_and_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AvailableShipmentsCubit(getIt<HomeRepo>())..fetchAvailableShipments(),
      child: Column(
        children: [
          // HomeHeaderContainer(),
          SizedBox(height: 21),
          RefreshButtonAndTitle(),
          SizedBox(height: 20),
          AvailableShipmentsListView(),
        ],
      ),
    );
  }
}
