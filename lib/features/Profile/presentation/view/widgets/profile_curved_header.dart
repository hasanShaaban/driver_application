import 'package:driver_application/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileCurvedHeader extends StatelessWidget {
  const ProfileCurvedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _DownwardArcClipper(),
      child: Container(
        width: double.infinity,
        height: 100,
        color: AppColors.appBarColor,
      ),
    );
  }
}

class _DownwardArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.4);
    path.quadraticBezierTo(size.width / 2, size.height, 0, size.height * 0.4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_DownwardArcClipper oldClipper) => false;
}
