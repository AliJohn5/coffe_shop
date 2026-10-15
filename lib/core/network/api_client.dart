import 'package:coffe_shop/app/config/app_config.dart';
import 'package:coffe_shop/app/di/injection.dart';
import 'package:coffe_shop/core/storage/token_storage.dart';
import 'package:dio/dio.dart';

class ApiClient {
  late final Dio _dio;
  Dio get instance => _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'App-Version': AppConfig.appVersion,
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final tokenStorage = AppInjection.getIt<TokenStorage>();
          final token = await tokenStorage.getAccessToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }
}
