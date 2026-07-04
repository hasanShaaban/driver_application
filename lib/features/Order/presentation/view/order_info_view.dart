import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_routes.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/core/utils/date_formatter.dart';
import 'package:driver_application/core/utils/widgets/custom_button.dart';
import 'package:driver_application/features/Order/presentation/view/widgets/order_number_container.dart';
import 'package:driver_application/features/home/data/models/shipments_response_model.dart';
import 'package:flutter/material.dart';

class OrderInfoView extends StatelessWidget {
  const OrderInfoView({super.key, required this.shipment});
  final Shipment shipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Icon(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OrderNumberContainer(
                id: shipment.id,
                date: DateFormatter.formatDate(shipment.createdAt),
              ),
              Divider(thickness: 1),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  children: [
                    Text(
                      'حالة الطلب ',
                      style: AppTextStyle.semiBold16.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.seconderyColor.withValues(alpha: 0.30),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'التحميل',
                        style: AppTextStyle.semiBold16.copyWith(
                          color: AppColors.seconderyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 19, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('تفاصيل الطلب', style: AppTextStyle.semiBold16),
                    OrderInfoRow(
                      title: 'تاريخ المهمة',
                      data: DateFormatter.formatDate(shipment.pickupAt),
                    ),
                    OrderInfoRow(
                      title: 'وقت المهمة',
                      data: DateFormatter.formatTime(shipment.pickupAt),
                    ),
                    OrderInfoRow(
                      title: 'موقع التحميل',
                      data: 'عرض التفاصيل',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.map,
                          arguments: {
                            'id': shipment.id,
                            'pickupLat': shipment.route.pickupLat,
                            'pickupLng': shipment.route.pickupLon,
                            'destinationLat': shipment.route.deliveryLat,
                            'destinationLng': shipment.route.deliveryLon,
                            'initialLocation': 'pickup',
                          },
                        );
                      },
                    ),
                    OrderInfoRow(
                      title: 'موقع التنزيل',
                      data: 'عرض التفاصيل',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.map,
                          arguments: {
                            'id': shipment.id,
                            'pickupLat': shipment.route.pickupLat,
                            'pickupLng': shipment.route.pickupLon,
                            'destinationLat': shipment.route.deliveryLat,
                            'destinationLng': shipment.route.deliveryLon,
                            'initialLocation': 'destination',
                          },
                        );
                      },
                    ),
                    OrderInfoRow(
                      title: 'نوع الحمولة',
                      data: shipment.goodsType,
                    ),
                    OrderInfoRow(
                      title: 'المسافة',
                      data: '${shipment.route.distance.toString()} km',
                    ),
                    OrderInfoRow(
                      title: 'عرض الصور',
                      data: 'عرض الصور',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              CustomButton(text: 'قبول الطلب', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderInfoRow extends StatelessWidget {
  const OrderInfoRow({
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
        Divider(thickness: 1.5, color: Colors.black26),
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.medium16.copyWith(color: Colors.black45),
            ),
            Spacer(),
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
