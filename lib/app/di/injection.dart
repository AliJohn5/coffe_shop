import 'package:coffe_shop/app/di/auth.dart';
import 'package:coffe_shop/app/di/network_client.dart';
import 'package:coffe_shop/app/di/secure_storage.dart';
import 'package:coffe_shop/app/di/settings.dart';
import 'package:get_it/get_it.dart';

class AppInjection {
  static final GetIt getIt = GetIt.instance;
  static bool _isConfigured = false;

  static Future<void> configureDependencies() async {
    if (_isConfigured) return;
    await configureNetworkClient(getIt);
    await configureSecureStorage(getIt);
    await configureSettings(getIt);
    await configureAuth(getIt);
    _isConfigured = true;
  }
}
