import 'package:driver_application/features/Order/presentation/view/order_info_view.dart';
import 'package:driver_application/features/Profile/presentation/view/my_rate_view.dart';
import 'package:driver_application/features/Profile/presentation/view/profile_info_view.dart';
import 'package:driver_application/features/Profile/presentation/view/profits_view.dart';
import 'package:driver_application/features/home/presentation/view/notifications_view.dart';
import 'package:flutter/material.dart';
import '../utils/app_routes.dart';
import '../../features/onBoarding/presentation/view/on_boarding_view.dart';
import '../../features/Auth/presentation/views/login_view.dart';
import '../../features/home/presentation/view/home_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.onBoarding:
      return MaterialPageRoute(
        builder: (context) => const OnBoardingView(),
        settings: settings,
      );
    case AppRoutes.login:
      return MaterialPageRoute(
        builder: (context) => const LoginView(),
        settings: settings,
      );
    case AppRoutes.home:
      return MaterialPageRoute(
        builder: (context) => const HomeView(),
        settings: settings,
      );
    case AppRoutes.myRate:
      return MaterialPageRoute(
        builder: (context) => const MyRateView(),
        settings: settings,
      );
    case AppRoutes.profileInfo:
      return MaterialPageRoute(
        builder: (context) => const ProfileInfoView(),
        settings: settings,
      );
    case AppRoutes.profits:
      return MaterialPageRoute(
        builder: (context) => const ProfitsView(),
        settings: settings,
      );
    case AppRoutes.notifications:
      return MaterialPageRoute(
        builder: (context) => const NotificationsView(),
        settings: settings,
      );
    case AppRoutes.orderInfo:
      return MaterialPageRoute(
        builder: (context) => const OrderInfoView(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
        settings: settings,
      );
  }
}
