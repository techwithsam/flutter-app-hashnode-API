import 'package:get_it/get_it.dart';
import 'package:hashnode/core/api.dart';
import 'package:hashnode/core/urls.dart';
import 'package:hashnode/functions/customFunc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseUrl());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => CustomFunction());
}
