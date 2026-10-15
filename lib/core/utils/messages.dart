import 'package:coffe_shop/app/routes/app_pages.dart';
import 'package:flutter/material.dart';


class AppMessages {
  AppMessages._();

  static void showError(String message) {
    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context == null) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static Future<T?> handle<T>(
    Future<T> Function() function, {
    String errorMessage = 'Something went wrong.',
  }) async {
    try {
      return await function();
    } catch (_) {
      showError(errorMessage);
      return null;
    }
  }
}
