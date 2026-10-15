import 'package:coffe_shop/app/settings/settings_cubit.dart';
import 'package:coffe_shop/app/settings/settings_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> configureSettings(GetIt getIt) async {
  getIt.registerLazySingleton<SharedPreferencesAsync>(
    () => SharedPreferencesAsync(),
  );

  getIt.registerLazySingleton<SettingsStorage>(
    () => SettingsStorage(getIt<SharedPreferencesAsync>()),
  );

  final settingsCubit = SettingsCubit(getIt<SettingsStorage>());

  await settingsCubit.load();

  getIt.registerSingleton<SettingsCubit>(settingsCubit);
}
