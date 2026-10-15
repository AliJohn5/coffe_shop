import 'package:coffe_shop/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

class SafeCall {
  SafeCall._();

  static Future<T?> wrap<T>(
    Future<T> Function() function, {
    bool showError = true,
  }) async {
    try {
      return await function();
    } catch (error) {
      if (showError) {
        showErrorMessage(error);
      }
      return null;
    }
  }

  static void showErrorMessage(Object error) {
    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(_getErrorMessage(error)),
          backgroundColor: Colors.red,
        ),
      );
  }

  static String _getErrorMessage(Object error) {
    // Customize this for Dio and your backend's error format.
    return error.toString();
  }
}
