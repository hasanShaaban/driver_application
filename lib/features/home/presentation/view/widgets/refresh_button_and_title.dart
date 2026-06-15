import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class RefreshButtonAndTitle extends StatefulWidget {
  const RefreshButtonAndTitle({super.key});

  @override
  State<RefreshButtonAndTitle> createState() => _RefreshButtonAndTitleState();
}

class _RefreshButtonAndTitleState extends State<RefreshButtonAndTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _animation = Tween<double>(begin: 0.75, end: 3.75).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onRefresh() {
    if (!_controller.isAnimating) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Row(
        children: [
          Text(
            'طلباتي الجديدة',
            style: AppTextStyle.bold14.copyWith(color: Colors.black),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _onRefresh,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RotationTransition(
                  turns: _animation,
                  child: const Icon(
                    Icons.refresh_rounded,
                    color: AppColors.seconderyColor,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'تحديث',
                  style: AppTextStyle.bold14.copyWith(
                    color: AppColors.seconderyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
