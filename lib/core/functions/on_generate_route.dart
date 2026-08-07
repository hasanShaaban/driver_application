import 'package:driver_application/features/OTP/domain/repo/otp_repo.dart';
import 'package:driver_application/features/OTP/presentation/manager/cubit/send_delivery_otp_cubit.dart';
import 'package:driver_application/features/OTP/presentation/manager/cubit/verify_delivery_otp_cubit.dart';
import 'package:driver_application/features/OTP/presentation/views/otp_view.dart';
import 'package:driver_application/features/Shipment/presentation/view/map_view.dart';
import 'package:driver_application/features/Shipment/presentation/view/shipment_info_view.dart';
import 'package:driver_application/features/Profile/presentation/view/my_rate_view.dart';
import 'package:driver_application/features/Profile/presentation/view/profile_info_view.dart';
import 'package:driver_application/features/Profile/presentation/view/profits_view.dart';
import 'package:driver_application/features/home/data/models/shipments_response_model.dart';
import 'package:driver_application/features/home/presentation/view/notifications_view.dart';
import 'package:flutter/material.dart';
import '../utils/app_routes.dart';
import '../../features/onBoarding/presentation/view/on_boarding_view.dart';
import '../../features/Auth/presentation/views/login_view.dart';
import '../../features/home/presentation/view/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/service_locator.dart';
import '../../features/Profile/domain/repo/profile_repo.dart';
import '../../features/Profile/presentation/manager/ratings_cubit/ratings_cubit.dart';
import '../../features/Profile/presentation/manager/profile_cubit/profile_cubit.dart';
import '../../features/Profile/data/model/profile_response_model.dart';

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
        builder: (context) => BlocProvider(
          create: (context) => ProfileCubit(getIt.get<ProfileRepo>()),
          child: const HomeView(),
        ),
        settings: settings,
      );
    case AppRoutes.myRate:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              RatingsCubit(getIt.get<ProfileRepo>())..fetchRatings(),
          child: const MyRateView(),
        ),
        settings: settings,
      );
    case AppRoutes.profileInfo:
      final profile = settings.arguments as ProfileDataModel?;
      if (profile == null) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('Profile data missing')),
          ),
        );
      }
      return MaterialPageRoute(
        builder: (context) => ProfileInfoView(profile: profile),
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
      final args = settings.arguments as Map<String, Shipment>;
      return MaterialPageRoute(
        builder: (context) =>
            ShipmentInfoView(shipment: args['shipment'] as Shipment),
        settings: settings,
      );
    case AppRoutes.shipmentImages:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) =>
            ShipmentImagesView(images: args['images'] as List<String>),
        settings: settings,
      );
    case AppRoutes.map:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => MapView(
          id: args['id'] as int,
          pickupLat: args['pickupLat'] as String,
          pickupLng: args['pickupLng'] as String,
          destinationLat: args['destinationLat'] as String,
          destinationLng: args['destinationLng'] as String,
          initialLocation: args['initialLocation'] as String,
        ),
        settings: settings,
      );
    case AppRoutes.otp:
      final args = settings.arguments as Map<String, dynamic>?;
      final shipmentId = args?['id'] as int?;
      return MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  SendDeliveryOtpCubit(getIt.get<OtpRepo>())..sendDeliveryOtp(),
            ),
            BlocProvider(
              create: (context) => VerifyDeliveryOtpCubit(getIt.get<OtpRepo>()),
            ),
          ],
          child: OTPView(shipmentId: shipmentId),
        ),
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
