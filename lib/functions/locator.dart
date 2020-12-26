import 'package:get_it/get_it.dart';
import 'package:hashnode/service/api.dart';
import 'package:hashnode/service/urls.dart';

GetIt locator = GetIt.instance; 

void setupLocator() {
  locator.registerLazySingleton(() => BaseUrl());
  locator.registerLazySingleton(() => Api());
}
