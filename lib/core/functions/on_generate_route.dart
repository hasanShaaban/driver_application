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
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
        settings: settings,
      );
  }
}
