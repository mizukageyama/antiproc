import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/core/network/network_info.dart';
import 'package:test/features/daily_record/data/datasources/daily_record_local_ds.dart';
import 'package:test/features/daily_record/data/datasources/daily_record_remote_ds.dart';
import 'package:test/features/daily_record/data/repositories/daily_record_repository.dart';
import 'package:test/features/daily_record/domain/repositories/daily_record_repository_intf.dart';
import 'package:test/features/daily_record/domain/usecases/get_daily_record_by_date.dart';
import 'package:test/features/daily_record/presentation/bloc/daily_record_bloc.dart';

//Service Locator
final sl = GetIt.instance;

void init() {
  //___________________ FEATURES ___________________
  //Feature - Daily Record
  //Bloc
  sl.registerFactory(() => DailyRecordBloc(getDailyRecordByDate: sl()));

  //Use cases
  sl.registerLazySingleton(() => GetDailyRecordByDate(sl()));

  //Repository
  sl.registerLazySingleton<DailyRecordRepositoryIntf>(
    () => DailyRecordRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Datasource
  sl.registerLazySingleton<DailyRecordRemoteDataSourceIntf>(
      () => DailyRecordRemoteDataSource(sl()));
  sl.registerLazySingleton<DailyRecordLocalDataSourceIntf>(
      () => DailyRecordLocalDataSource(sl()));

  //___________________ CORE ___________________
  sl.registerLazySingleton<NetworkInfoIntf>(() => NetworkInfo(sl()));

  //___________________EXTERNAL ___________________
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
