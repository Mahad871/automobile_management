import 'package:automobile_management/models/auth_method.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
init() {
  sl.registerLazySingleton(() => AuthMethod());
}

