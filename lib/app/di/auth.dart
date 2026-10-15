import 'package:coffe_shop/core/network/api_client.dart';
import 'package:coffe_shop/core/storage/token_storage.dart';
import 'package:coffe_shop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:coffe_shop/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:coffe_shop/features/auth/domain/repositories/auth_repository.dart';
import 'package:coffe_shop/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:coffe_shop/features/auth/domain/usecases/sign_in.dart';
import 'package:coffe_shop/features/auth/domain/usecases/sign_up.dart';
import 'package:coffe_shop/features/auth/domain/usecases/sign_out.dart';
import 'package:coffe_shop/features/auth/domain/usecases/get_current_user.dart';

Future<void> configureAuth(GetIt getIt) async {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      tokenStorage: getIt<TokenStorage>(),
    ),
  );

  getIt.registerLazySingleton(() => SignIn(getIt<AuthRepository>()));

  getIt.registerLazySingleton(() => SignUp(getIt<AuthRepository>()));

  getIt.registerLazySingleton(() => SignOut(getIt<AuthRepository>()));

  getIt.registerLazySingleton(() => GetCurrentUser(getIt<AuthRepository>()));

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      signIn: getIt<SignIn>(),
      signUp: getIt<SignUp>(),
      signOut: getIt<SignOut>(),
      getCurrentUser: getIt<GetCurrentUser>(),
    ),
  );
}
