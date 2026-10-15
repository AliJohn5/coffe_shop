import 'package:coffe_shop/app/routes/app_pages.dart';
import 'package:coffe_shop/app/routes/app_routes.dart';
import 'package:coffe_shop/core/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Shop'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            onPressed: () {
              Loading.wrap(() async {
                await context.read<AuthCubit>().signOut();
              });
            },
            icon: const Icon(Icons.logout),
          ),

          IconButton(
            tooltip: 'Settings',
            onPressed: () {
              AppRouter.toNamed(AppRoutes.settings);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Text(
              'Welcome${state.user?.name == null ? '' : ', ${state.user!.name}'}!',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}
