import 'package:coffe_shop/core/network/api_client.dart';
import 'package:get_it/get_it.dart';

Future<void> configureNetworkClient(GetIt getIt) async {
  getIt.registerLazySingleton<ApiClient>(() {
    return ApiClient();
  });
}
