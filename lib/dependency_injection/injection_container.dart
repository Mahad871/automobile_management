import 'package:automobile_management/models/auth_method.dart';
import 'package:get_it/get_it.dart';

import '../models/SearchController.dart';
import '../models/firebase_storage_model.dart';
import '../models/profile_controller.dart';
import '../models/signin_controller.dart';
import '../models/signup_controller.dart';
import '../services/product_api.dart';

final sl = GetIt.instance;

init() {
  sl.registerLazySingleton<AuthMethod>(
    () => AuthMethod(),
  );
  sl.registerLazySingleton<ProfileProvider>(
    () => ProfileProvider(),
  );

  sl.registerLazySingleton<SignUpController>(
    () => SignUpController(),
  );

  sl.registerLazySingleton<SignInController>(
    () => SignInController(),
  );

  sl.registerLazySingleton<FirebaseStorageModel>(
    () => FirebaseStorageModel(),
  );
  sl.registerLazySingleton<SearchController>(
    () => SearchController(),
  );
  sl.registerLazySingleton<ProductApi>(
    () => ProductApi(),
  );
}
