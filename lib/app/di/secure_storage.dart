import 'package:coffe_shop/core/storage/token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

Future<void> configureSecureStorage(GetIt getIt) async {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<TokenStorage>(
    () => TokenStorage(getIt<FlutterSecureStorage>()),
  );
}
