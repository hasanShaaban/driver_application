import 'package:driver_application/features/home/presentation/view/widgets/order_card.dart';
import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 21),
        Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return OrderCard();
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
