import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hncg_app/core/network/dio_client.dart';
import 'package:hncg_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hncg_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hncg_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:hncg_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:hncg_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:hncg_app/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<DioClient>(DioClient(sl()));

  // Auth
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(dioClient: sl()));
  
  // Use cases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase(sl()));
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase(sl()));

  // BLoC
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
}