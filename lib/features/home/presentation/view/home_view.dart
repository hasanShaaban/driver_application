import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/features/home/presentation/view/widgets/home_page.dart';
import 'package:driver_application/features/home/presentation/view/widgets/my_orders_pagge.dart';
import 'package:driver_application/features/Profile/presentation/view/profile_page.dart';
import 'package:driver_application/generated/assets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [HomePage(), MyOrdersPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _currentIndex == 1
            ? Text(
                'رحلاتي',
                style: AppTextStyle.semiBold20.copyWith(color: Colors.black),
              )
            : null,
        elevation: 0,
        backgroundColor: _currentIndex == 2
            ? AppColors.appBarColor
            : Colors.white,
        leading: Icon(
          Icons.notifications,
          size: 26,
          color: AppColors.primaryColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Icon(
              Icons.menu_rounded,
              size: 24,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _pages[_currentIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      spreadRadius: 0,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: AppColors.primaryColor,
                  unselectedItemColor: const Color(0xFF807F7F),
                  selectedLabelStyle: AppTextStyle.semiBold10,
                  unselectedLabelStyle: AppTextStyle.semiBold10,
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        _currentIndex == 0
                            ? Assets.iconsHomeActive
                            : Assets.iconsHomeInactive,
                        width: 28,
                        height: 28,
                      ),
                      label: 'الرئيسية',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        _currentIndex == 1
                            ? Assets.iconsOrdersActive
                            : Assets.iconsOrdersInactive,
                        width: 28,
                        height: 28,
                      ),
                      label: 'رحلاتي',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        _currentIndex == 2
                            ? Icons.person
                            : Icons.person_outline_rounded,
                        size: 28,
                      ),
                      label: 'الملف الشخصي',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
