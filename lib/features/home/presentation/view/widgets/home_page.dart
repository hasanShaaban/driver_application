import 'package:driver_application/features/home/presentation/view/widgets/home_header_container.dart';
import 'package:driver_application/features/home/presentation/view/widgets/order_card.dart';
import 'package:driver_application/features/home/presentation/view/widgets/refresh_button_and_title.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeaderContainer(),
        SizedBox(height: 21),
        RefreshButtonAndTitle(),
        SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return OrderCard();
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
