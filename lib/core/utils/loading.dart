import 'package:coffe_shop/app/routes/app_pages.dart';
import 'package:flutter/material.dart';



class Loading {
  Loading._();

  static bool _isShowing = false;

  static Future<T?> wrap<T>(
    Future<T> Function() function, {
    bool showError = true,
  }) async {
    final context = AppRouter.rootNavigatorKey.currentContext;

    if (context == null || _isShowing) {
      try {
        return await function();
      } catch (error) {
        if (showError) {
          showErrorMessage(error);
        }
        return null;
      }
    }

    _isShowing = true;
    BuildContext? dialogContext;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogContext = ctx;
        return const PopScope(
          canPop: false,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );

    await Future<void>.delayed(Duration.zero);

    try {
      return await function();
    } catch (error) {
      if (showError) {
        showErrorMessage(error);
      }
      return null;
    } finally {
      if (dialogContext != null && dialogContext!.mounted) {
        Navigator.of(dialogContext!).pop();
      }
      _isShowing = false;
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
