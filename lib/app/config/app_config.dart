abstract final class AppConfig {
  static const appName = 'Coffee Shop';
  static const appVersion = '1.0.0';

  //TODO: Replace with your actual backend URL when available.
  static const baseUrl = 'https://example.com/api/';

  static const connectTimeout = Duration(seconds: 60);
  static const receiveTimeout = Duration(seconds: 60);
}
