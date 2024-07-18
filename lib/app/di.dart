import 'package:_tut_app/app/app_prefs.dart';
import 'package:_tut_app/data/data_source/remote_data_source.dart';
import 'package:_tut_app/data/network/app_api.dart';
import 'package:_tut_app/data/network/dio_factory.dart';
import 'package:_tut_app/data/network_info.dart';
import 'package:_tut_app/data/repository/repository_impl.dart';
import 'package:_tut_app/domain/repository/repository.dart';
import 'package:_tut_app/domain/usecase/login_usecase.dart';
import 'package:_tut_app/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

//network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //app service client
  // DioFactory dioFactory = DioFactory(_appPreferences);
  // dioFactory.getDio();

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));

  initLoginModule();
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
