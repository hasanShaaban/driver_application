import 'package:dio/dio.dart';
import 'package:driver_application/core/network/api_service.dart';
import 'package:driver_application/core/storage/app_storage.dart';
import 'package:driver_application/core/storage/hive_storage_impl.dart';
import 'package:driver_application/features/Auth/data/repo/auth_repo_impl.dart';
import 'package:driver_application/features/Auth/domain/repo/auth_repo.dart';
import 'package:driver_application/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:driver_application/features/home/data/repo/home_repo_impl.dart';
import 'package:driver_application/features/home/domain/repo/home_repo.dart';
import 'package:driver_application/features/Order/data/repo/order_repo_impl.dart';
import 'package:driver_application/features/Order/domain/repo/order_repo.dart';
import 'package:driver_application/features/Profile/data/repo/profile_repo_impl.dart';
import 'package:driver_application/features/Profile/domain/profile_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AppStorage>(HiveStorageImpl());
  getIt.registerSingleton<AuthLocalDataSource>(
    AuthLocalDataSourceImpl(appStorage: getIt.get<AppStorage>()),
  );
  getIt.registerSingleton<AuthRepo>(
    LoginRepoImpl(
      apiService: getIt.get<ApiService>(),
      localDataSource: getIt.get<AuthLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<OrderRepo>(OrderRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<ProfileRepo>(
    ProfileRepoImpl(
      apiService: getIt.get<ApiService>(),
      authLocalDataSource: getIt.get<AuthLocalDataSource>(),
    ),
  );
}
