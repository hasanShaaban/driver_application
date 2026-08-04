import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:driver_application/core/notifications/services/push_notification_service.dart';
import 'package:driver_application/core/notifications/services/firebase_push_notification_service_impl.dart';
import 'package:driver_application/features/home/presentation/view/home_view.dart';
import 'package:driver_application/features/onBoarding/presentation/view/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:driver_application/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/functions/on_generate_route.dart';
import 'generated/l10n.dart';

import 'core/utils/service_locator.dart';
import 'core/storage/app_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator();
  await getIt.get<PushNotificationService>().initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  await getIt.get<AppStorage>().init();

  final authLocalDataSource = getIt.get<AuthLocalDataSource>();
  final loginData = authLocalDataSource.getLoginData();
  final bool isLoggedIn =
      loginData != null && loginData.data.accessToken.isNotEmpty;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        fontFamily: 'Zahir',
      ),

      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      // Using `home` instead of `initialRoute` so Flutter does NOT silently
      // push '/' (OnBoardingView) underneath the HomeView when the user is
      // already logged in. With `initialRoute: '/home'`, Flutter would push
      // '/' first, leaving OnBoardingView in the back-stack.
      home: isLoggedIn ? const HomeView() : const OnBoardingView(),
    );
  }
}
