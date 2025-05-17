import 'package:get_it/get_it.dart';
import 'package:hncgparty/core/network/dio_client.dart';
import 'package:hncgparty/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hncgparty/features/auth/domain/repositories/auth_repository.dart';
import 'package:hncgparty/features/auth/domain/usecases/login_usecase.dart';
import 'package:hncgparty/features/auth/domain/usecases/signup_usecase.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerSingleton(await SharedPreferences.getInstance());

  // Core
  sl.registerSingleton(DioClient());

  // Auth Feature
  sl.registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(dioClient: sl<DioClient>()),
  );

  // Đăng ký riêng từng UseCase
  sl.registerFactory(() => LoginUseCase(repository: sl<AuthRepository>()));
  sl.registerFactory(() => SignupUseCase(repository: sl<AuthRepository>()));

  // Đăng ký AuthBloc
  sl.registerFactory(
        () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      signupUseCase: sl<SignupUseCase>(),
    ),
  );
}