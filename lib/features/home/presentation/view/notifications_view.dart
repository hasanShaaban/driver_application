import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'الاشعارات',
          style: AppTextStyle.medium18.copyWith(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
