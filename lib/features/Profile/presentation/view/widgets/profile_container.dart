import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key, required this.content});
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: List.generate(content.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == content.length - 1 ? 0 : 13,
            ),
            child: content[index],
          );
        }),
      ),
    );
  }
}
