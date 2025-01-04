

import 'package:doit_today/core/services/alert_service/alert_service.dart';
import 'package:doit_today/core/services/navigation_service/navigation_service.dart';
import 'package:doit_today/core/services/sql_service/sql_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;


Future<void> setupLocator() async {
  final dbInstance = await SqlService.getInstance();

  locator..registerLazySingleton(NavigationService.new)
  ..registerSingleton<SqlService>(dbInstance)
  ..registerLazySingleton(AlertService.new);

}


