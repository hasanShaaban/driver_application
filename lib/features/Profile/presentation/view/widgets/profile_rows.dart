import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FunctionalProfileRow extends StatelessWidget {
  const FunctionalProfileRow({
    super.key,
    required this.textButton,
    required this.icon,
    required this.onTap,
    required this.text,
  });
  final String textButton;
  final String text;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Text(
            textButton,
            style: AppTextStyle.regular15.copyWith(
              color: AppColors.seconderyColor,
            ),
          ),
        ),
        Spacer(),
        Text(text, style: AppTextStyle.regular15),
        SizedBox(width: 13),
        SvgPicture.asset(icon),
      ],
    );
  }
}

class NonFunctionalProfileRow extends StatelessWidget {
  const NonFunctionalProfileRow({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(text, style: AppTextStyle.regular15),
            SizedBox(width: 13),
            SvgPicture.asset(icon),
          ],
        ),
      ),
    );
  }
}
