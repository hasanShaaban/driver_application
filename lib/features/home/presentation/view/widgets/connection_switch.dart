import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class ConnectionSwitch extends StatefulWidget {
  const ConnectionSwitch({super.key});

  @override
  State<ConnectionSwitch> createState() => _ConnectionSwitchState();
}

class _ConnectionSwitchState extends State<ConnectionSwitch> {
  bool _isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _isConnected ? 'متصل' : 'غير متصل',
          style: AppTextStyle.bold14.copyWith(
            color: _isConnected ? const Color(0xFF2FD1CD) : Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              _isConnected = !_isConnected;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _isConnected
                  ? const Color(0xff2DD0CB)
                  : Colors.grey.shade400,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            alignment: _isConnected
                ? AlignmentDirectional.centerStart
                : AlignmentDirectional.centerEnd,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
