import 'dart:developer';

import 'package:driver_application/core/functions/get_status_text.dart';
import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_routes.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/core/utils/date_formatter.dart';
import 'package:driver_application/core/utils/service_locator.dart';
import 'package:driver_application/core/utils/widgets/custom_button.dart';
import 'package:driver_application/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:driver_application/features/Shipment/domain/repo/shipment_repo.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/accept_shipment_cubit.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/accept_shipment_state.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/cancel_shipment_cubit.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/cancel_shipment_state.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/update_location_cubit.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/update_trip_status_cubit.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/update_trip_status_state.dart';
import 'package:driver_application/features/Shipment/presentation/view/widgets/cancel_shipment_dialog.dart';
import 'package:driver_application/features/Shipment/presentation/view/widgets/shipment_number_container.dart';
import 'package:driver_application/features/home/data/models/shipments_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShipmentInfoView extends StatefulWidget {
  const ShipmentInfoView({super.key, required this.shipment});
  final Shipment shipment;

  @override
  State<ShipmentInfoView> createState() => _ShipmentInfoViewState();
}

class _ShipmentInfoViewState extends State<ShipmentInfoView> {
  late Shipment currentShipment;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    currentShipment = widget.shipment;
  }

  void _evaluateLocationTracking(BuildContext context) {
    final loginData = getIt.get<AuthLocalDataSource>().getLoginData();
    final currentDriverId = loginData?.data.id;
    final currentDriverUid = loginData?.data.uid;

    final bool isTakenByMe =
        currentShipment.driver != null &&
        (currentShipment.driver!.id == currentDriverId ||
            currentShipment.driver!.uid == currentDriverUid);

    final String currentStatus = selectedStatus ?? currentShipment.status;
    log('isTakenByMe: $isTakenByMe');
    log('currentStatus: $currentStatus');
    context.read<UpdateLocationCubit>().startLocationTracking(
      isTakenByMe: isTakenByMe,
      status: currentStatus,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AcceptShipmentCubit(getIt.get<OrderRepo>()),
        ),
        BlocProvider(
          create: (context) => UpdateTripStatusCubit(getIt.get<OrderRepo>()),
        ),
        BlocProvider(
          create: (context) => UpdateLocationCubit(getIt.get<OrderRepo>()),
        ),
        BlocProvider(
          create: (context) => CancelShipmentCubit(getIt.get<OrderRepo>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _evaluateLocationTracking(context);
          });
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.notifications,
                        color: AppColors.primaryColor,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 0,
              title: Text(
                'تفاصيل الطلب',
                style: AppTextStyle.medium18.copyWith(color: Colors.black),
              ),
            ),
            body: BlocConsumer<AcceptShipmentCubit, AcceptShipmentState>(
              listener: (context, acceptState) {
                if (acceptState is AcceptShipmentSuccess) {
                  setState(() {
                    currentShipment = acceptState.responseModel.data;
                    selectedStatus = null;
                  });
                  _evaluateLocationTracking(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(acceptState.responseModel.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (acceptState is AcceptShipmentFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(acceptState.errMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, acceptState) {
                return BlocConsumer<CancelShipmentCubit, CancelShipmentState>(
                  listener: (context, cancelState) {
                    if (cancelState is CancelShipmentSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم إلغاء الشحنة بنجاح'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pop();
                    } else if (cancelState is CancelShipmentFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(cancelState.errMessage),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, cancelState) {
                    return BlocConsumer<
                      UpdateTripStatusCubit,
                      UpdateTripStatusState
                    >(
                      listener: (context, updateState) {
                        if (updateState is UpdateTripStatusSuccess) {
                          setState(() {
                            currentShipment = updateState.responseModel.data;
                            selectedStatus = null;
                          });
                          _evaluateLocationTracking(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(updateState.responseModel.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else if (updateState is UpdateTripStatusFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(updateState.errMessage),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, updateState) {
                        final bool isUpdateLoading =
                            updateState is UpdateTripStatusLoading;
                        final loginData = getIt
                            .get<AuthLocalDataSource>()
                            .getLoginData();
                        final currentDriverId = loginData?.data.id;
                        final currentDriverUid = loginData?.data.uid;

                        final bool hasNoDriver = currentShipment.driver == null;
                        final bool isTakenByMe =
                            currentShipment.driver != null &&
                            (currentShipment.driver!.id == currentDriverId ||
                                currentShipment.driver!.uid == currentDriverUid);

                        final String currentStatus =
                            selectedStatus ?? currentShipment.status;
                        final bool isHeadingToPickupEnabled =
                            isTakenByMe &&
                            (currentStatus == 'accepted' ||
                                currentStatus == 'scheduled');
                        final bool isInTransitEnabled =
                            isTakenByMe && currentStatus == 'heading_to_pickup';
                        final bool isCancelEnabled =
                            isTakenByMe && currentStatus == 'heading_to_pickup';

                        String buttonText;
                        VoidCallback? onButtonTap;

                        if (hasNoDriver) {
                          buttonText = 'قبول الطلب';
                          onButtonTap = () {
                            context.read<AcceptShipmentCubit>().acceptShipment(
                              shipmentId: currentShipment.id,
                            );
                          };
                        } else if (isTakenByMe) {
                          buttonText = 'إنهاء الشحنة';
                          onButtonTap = currentStatus == 'in_transit'
                              ? () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.otp,
                                  );
                                }
                              : null;
                        } else {
                          buttonText = 'تم قبول الشحنة من قبل سائق آخر';
                          onButtonTap = null;
                        }

                        return SafeArea(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShipmentNumberContainer(
                                  id: currentShipment.id,
                                  date: DateFormatter.formatDate(
                                    currentShipment.createdAt,
                                  ),
                                ),
                                const Divider(thickness: 1),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 11,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'حالة الطلب ',
                                            style: AppTextStyle.semiBold16.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          const Spacer(),
                                          PopupMenuButton<String>(
                                            enabled:
                                                !isUpdateLoading &&
                                                (isHeadingToPickupEnabled ||
                                                    isInTransitEnabled ||
                                                    isCancelEnabled),
                                            onSelected: (String value) {
                                              if (value == 'cancel') {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (_) =>
                                                      CancelShipmentDialog(
                                                        shipmentId:
                                                            currentShipment.id,
                                                        cancelCubit: context
                                                            .read<
                                                              CancelShipmentCubit
                                                            >(),
                                                      ),
                                                );
                                              } else {
                                                context
                                                    .read<
                                                      UpdateTripStatusCubit
                                                    >()
                                                    .updateTripStatus(
                                                      id: currentShipment.id,
                                                      status: value,
                                                    );
                                              }
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            itemBuilder:
                                                (BuildContext context) => [
                                                  PopupMenuItem<String>(
                                                    value: 'heading_to_pickup',
                                                    enabled:
                                                        isHeadingToPickupEnabled,
                                                    child: Text(
                                                      'في الطريق إلى موقع التحميل',
                                                      style: AppTextStyle
                                                          .medium14
                                                          .copyWith(
                                                            color:
                                                                isHeadingToPickupEnabled
                                                                ? Colors.black
                                                                : Colors.grey,
                                                          ),
                                                    ),
                                                  ),
                                                  PopupMenuItem<String>(
                                                    value: 'in_transit',
                                                    enabled: isInTransitEnabled,
                                                    child: Text(
                                                      'جاري التوصيل',
                                                      style: AppTextStyle
                                                          .medium14
                                                          .copyWith(
                                                            color:
                                                                isInTransitEnabled
                                                                ? Colors.black
                                                                : Colors.grey,
                                                          ),
                                                    ),
                                                  ),
                                                  if (isCancelEnabled)
                                                    PopupMenuItem<String>(
                                                      value: 'cancel',
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            color: AppColors
                                                                .failedColor,
                                                            size: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            'إلغاء الشحنة',
                                                            style: AppTextStyle
                                                                .medium14
                                                                .copyWith(
                                                                  color: AppColors
                                                                      .failedColor,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: AppColors.seconderyColor
                                                    .withValues(alpha: 0.30),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    getStatusText(currentStatus),
                                                    style: AppTextStyle
                                                        .semiBold16
                                                        .copyWith(
                                                          color: AppColors
                                                              .seconderyColor,
                                                        ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Icon(
                                                    Icons.arrow_drop_down,
                                                    color:
                                                        AppColors.seconderyColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (isUpdateLoading) ...[
                                        const SizedBox(height: 8),
                                        const ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(4),
                                          ),
                                          child: LinearProgressIndicator(
                                            color: AppColors.primaryColor,
                                            backgroundColor: Colors.white,
                                            minHeight: 3,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 19,
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'تفاصيل الطلب',
                                        style: AppTextStyle.semiBold16,
                                      ),
                                      ShipmentInfoRow(
                                        title: 'تاريخ المهمة',
                                        data: DateFormatter.formatDate(
                                          currentShipment.pickupAt,
                                        ),
                                      ),
                                      ShipmentInfoRow(
                                        title: 'وقت المهمة',
                                        data: DateFormatter.formatTime(
                                          currentShipment.pickupAt,
                                        ),
                                      ),
                                      ShipmentInfoRow(
                                        title: 'موقع التحميل',
                                        data: 'عرض التفاصيل',
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.map,
                                            arguments: {
                                              'id': currentShipment.id,
                                              'pickupLat': currentShipment
                                                  .route
                                                  .pickupLat,
                                              'pickupLng': currentShipment
                                                  .route
                                                  .pickupLon,
                                              'destinationLat': currentShipment
                                                  .route
                                                  .deliveryLat,
                                              'destinationLng': currentShipment
                                                  .route
                                                  .deliveryLon,
                                              'initialLocation': 'pickup',
                                            },
                                          );
                                        },
                                      ),
                                      ShipmentInfoRow(
                                        title: 'موقع التنزيل',
                                        data: 'عرض التفاصيل',
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.map,
                                            arguments: {
                                              'id': currentShipment.id,
                                              'pickupLat': currentShipment
                                                  .route
                                                  .pickupLat,
                                              'pickupLng': currentShipment
                                                  .route
                                                  .pickupLon,
                                              'destinationLat': currentShipment
                                                  .route
                                                  .deliveryLat,
                                              'destinationLng': currentShipment
                                                  .route
                                                  .deliveryLon,
                                              'initialLocation': 'destination',
                                            },
                                          );
                                        },
                                      ),
                                      ShipmentInfoRow(
                                        title: 'نوع الحمولة',
                                        data: currentShipment.goodsType,
                                      ),
                                      ShipmentInfoRow(
                                        title: 'المسافة',
                                        data:
                                            '${currentShipment.route.distance.toString()} km',
                                      ),
                                      ShipmentInfoRow(
                                        title: 'الصور',
                                        data: currentShipment.mediaUrls.isEmpty
                                            ? 'لا توجد صور'
                                            : 'عرض الصور',
                                        onTap: () {
                                          if (currentShipment
                                              .mediaUrls
                                              .isNotEmpty) {
                                            Navigator.pushNamed(
                                              context,
                                              AppRoutes.shipmentImages,
                                              arguments: {
                                                'images':
                                                    currentShipment.mediaUrls,
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                CustomButton(
                                  text: buttonText,
                                  isLoading:
                                      acceptState is AcceptShipmentLoading,
                                  onTap: onButtonTap,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ShipmentInfoRow extends StatelessWidget {
  const ShipmentInfoRow({
    super.key,
    required this.title,
    required this.data,
    this.onTap,
  });
  final String title;
  final String data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1.5, color: Colors.black26),
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.medium16.copyWith(color: Colors.black45),
            ),
            const Spacer(),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Text(
                  data,
                  style: AppTextStyle.medium16.copyWith(
                    color: onTap == null
                        ? Colors.black45
                        : AppColors.appBarColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ShipmentImagesView extends StatelessWidget {
  const ShipmentImagesView({super.key, required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صور الشحنة'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
      ),
      body: PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            child: Image.network(
              images[index],
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error, size: 50)),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        },
      ),
    );
  }
}
