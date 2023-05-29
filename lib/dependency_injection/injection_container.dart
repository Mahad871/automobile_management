import 'package:automobile_management/databases/chat_api.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/providers/SearchController.dart';
import 'package:automobile_management/providers/profile_controller.dart';
import 'package:automobile_management/providers/signin_controller.dart';
import 'package:automobile_management/providers/signup_controller.dart';
import 'package:automobile_management/services/location_api.dart';
import 'package:get_it/get_it.dart';

// import '../Screens/chat/repositories/chat_repository.dart';
import '../models/firebase_storage_model.dart';

import '../providers/chat/chat_page_provider.dart';
import '../providers/user/user_provider.dart';
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
  sl.registerLazySingleton<LocationApi>(
    () => LocationApi(),
  );
  sl.registerLazySingleton<UserProvider>(
    () => UserProvider(),
  );

  sl.registerLazySingleton<ChatPageProvider>(
    () => ChatPageProvider(),
  );
  sl.registerLazySingleton<ChatAPI>(
    () => ChatAPI(),
  );
}
