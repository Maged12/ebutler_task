import 'package:dio/dio.dart';
import 'package:ebutler_task/core/api/app_interceptors.dart';
import 'package:ebutler_task/core/api/dio_consumer.dart';
import 'package:ebutler_task/core/app/app_prefs.dart';
import 'package:ebutler_task/core/network/netwok_info.dart';
import 'package:ebutler_task/features/auth_feature/data/datasources/auth_local_data_source.dart';
import 'package:ebutler_task/features/auth_feature/data/repositories/auth_repository_impl.dart';
import 'package:ebutler_task/features/auth_feature/domain/repositories/auth_repository.dart';
import 'package:ebutler_task/features/auth_feature/presentation/cubit/auth_feature_cubit.dart';
import 'package:ebutler_task/features/users_feature/data/datasources/users_remote_data_source.dart';
import 'package:ebutler_task/features/users_feature/data/repositories/users_repository_impl.dart';
import 'package:ebutler_task/features/users_feature/domain/repositories/users_repository.dart';
import 'package:ebutler_task/features/users_feature/domain/usecases/get_users_usecase.dart';
import 'package:ebutler_task/features/users_feature/presentation/cubit/users_feature_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth_feature/domain/usecases/login_usecase.dart';
import '../api/api_consumer.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance.registerLazySingleton<Dio>(() => Dio());

  instance.registerLazySingleton<AppIntercepters>(() => AppIntercepters());
  instance.registerLazySingleton<LogInterceptor>(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(
      instance<SharedPreferences>(),
    ),
  );

  instance.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(
      client: instance<Dio>(),
    ),
  );
  // network info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: InternetConnectionChecker(),
    ),
  );

  // local data source
  instance.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      prefs: instance<AppPreferences>(),
    ),
  );

  // remote data source
  instance.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImpl(
      apiConsumer: instance<ApiConsumer>(),
    ),
  );

  // repository
  instance.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: instance<NetworkInfo>(),
      authLocalDataSource: instance<AuthLocalDataSource>(),
    ),
  );

  instance.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(
      networkInfo: instance<NetworkInfo>(),
      usersRemoteDataSource: instance<UsersRemoteDataSource>(),
    ),
  );
}

initAuthModule() {
  if (!instance.isRegistered<AuthFeatureCubit>()) {
    instance.registerFactory<LoginOrRegister>(
      () => LoginOrRegister(
        authRepository: instance<AuthRepository>(),
      ),
    );
    instance.registerFactory<AuthFeatureCubit>(
      () => AuthFeatureCubit(instance<LoginOrRegister>()),
    );
  }
}

initUsersModule() {
  if (!instance.isRegistered<UsersFeatureCubit>()) {
    instance.registerFactory<GetUsers>(
      () => GetUsers(
        usersRepository: instance<UsersRepository>(),
      ),
    );
    instance.registerFactory<UsersFeatureCubit>(
      () => UsersFeatureCubit(
        usersRepository: instance<UsersRepository>(),
      ),
    );
  }
}
