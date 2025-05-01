import 'package:get_it/get_it.dart';
import 'package:hncgparty/core/network/dio_client.dart';
import 'package:hncgparty/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hncgparty/features/auth/domain/repositories/auth_repository.dart';
import 'package:hncgparty/features/auth/domain/usecases/login_usecase.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 1. Đăng ký SharedPreferences (external dependency)
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPrefs);

  // 2. Đăng ký DioClient (core dependency)
  sl.registerSingleton<DioClient>(DioClient());

  // 3. Đăng ký AuthRepositoryImpl với đầy đủ dependencies
  sl.registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(
      dioClient: sl.get<DioClient>(),  // Lấy DioClient đã đăng ký
    ),
  );

  // 4. Đăng ký LoginUseCase
  sl.registerFactory<LoginUseCase>(
        () => LoginUseCase(
      repository: sl.get<AuthRepository>(),  // Lấy AuthRepository đã đăng ký
    ),
  );

  // 5. Đăng ký AuthBloc
  sl.registerFactory<AuthBloc>(
        () => AuthBloc(
      loginUseCase: sl.get<LoginUseCase>(),  // Lấy LoginUseCase đã đăng ký
    ),
  );
}