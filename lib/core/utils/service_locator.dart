import 'package:dio/dio.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/core/storage/app_storage.dart';
import 'package:driver_application/core/storage/hive_storage_impl.dart';
import 'package:driver_application/features/Auth/data/repo/auth_repo_impl.dart';
import 'package:driver_application/features/Auth/domain/repo/auth_repo.dart';
import 'package:driver_application/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:driver_application/features/home/data/repo/home_repo_impl.dart';
import 'package:driver_application/features/home/domain/repo/home_repo.dart';
import 'package:driver_application/features/Shipment/data/data_source/shipment_local_data_source_impl.dart';
import 'package:driver_application/features/Shipment/domain/data_source/shipment_local_data_source.dart';
import 'package:driver_application/features/Shipment/data/repo/shipment_repo_impl.dart';
import 'package:driver_application/features/Shipment/domain/repo/shipment_repo.dart';
import 'package:driver_application/features/home/data/repo/my_shipments_repo_impl.dart';
import 'package:driver_application/features/home/domain/repo/my_shipments_repo.dart';
import 'package:driver_application/features/OTP/data/repo/otp_repo_impl.dart';
import 'package:driver_application/features/OTP/domain/repo/otp_repo.dart';
import 'package:driver_application/features/Profile/data/repo/profile_repo_impl.dart';
import 'package:driver_application/features/Profile/domain/profile_repo.dart';
import 'package:driver_application/core/notifications/repo/notification_repo.dart';
import 'package:driver_application/core/notifications/repo/notification_repo_impl.dart';
import 'package:driver_application/core/notifications/services/local_notification_service.dart';
import 'package:driver_application/core/notifications/services/flutter_local_notification_service_impl.dart';
import 'package:driver_application/core/notifications/services/push_notification_service.dart';
import 'package:driver_application/core/notifications/services/firebase_push_notification_service_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AppStorage>(HiveStorageImpl());
  getIt.registerSingleton<LocalNotificationService>(
    FlutterLocalNotificationServiceImpl(),
  );
  getIt.registerSingleton<PushNotificationService>(
    FirebasePushNotificationServiceImpl(
      localNotificationService: getIt.get<LocalNotificationService>(),
    ),
  );
  getIt.registerSingleton<AuthLocalDataSource>(
    AuthLocalDataSourceImpl(appStorage: getIt.get<AppStorage>()),
  );
  getIt.registerSingleton<AuthRepo>(
    LoginRepoImpl(
      apiService: getIt.get<ApiService>(),
      localDataSource: getIt.get<AuthLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<NotificationRepo>(
    NotificationRepoImpl(
      getIt.get<ApiService>(),
      getIt.get<PushNotificationService>(),
    ),
  );
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ShipmentLocalDataSource>(
    ShipmentLocalDataSourceImpl(appStorage: getIt.get<AppStorage>()),
  );
  getIt.registerSingleton<OrderRepo>(
    OrderRepoImpl(
      apiService: getIt.get<ApiService>(),
      shipmentLocalDataSource: getIt.get<ShipmentLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<MyShipmentsRepo>(
    MyShipmentsRepoImpl(
      shipmentLocalDataSource: getIt.get<ShipmentLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<ProfileRepo>(
    ProfileRepoImpl(
      apiService: getIt.get<ApiService>(),
      authLocalDataSource: getIt.get<AuthLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<OtpRepo>(
    OtpRepoImpl(
      getIt.get<ApiService>(),
      shipmentLocalDataSource: getIt.get<ShipmentLocalDataSource>(),
    ),
  );
}
