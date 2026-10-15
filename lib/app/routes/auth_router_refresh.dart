import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';

class AuthRouterRefresh extends ChangeNotifier {
  AuthRouterRefresh(AuthCubit cubit) {
    _subscription = cubit.stream.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
