import 'package:get_it/get_it.dart';
import 'package:hncgparty/core/network/dio_client.dart';
import 'package:hncgparty/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hncgparty/features/auth/domain/repositories/auth_repository.dart';
import 'package:hncgparty/features/auth/domain/usecases/login_usecase.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerSingleton(await SharedPreferences.getInstance());

  // Core
  sl.registerSingleton(DioClient()); // Đăng ký DioClient trước

  // Auth Feature
  sl.registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(dioClient: sl<DioClient>()), // Sửa thành sl<DioClient>()
  );

  sl.registerFactory(
        () => LoginUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerFactory(
        () => AuthBloc(loginUseCase: sl<LoginUseCase>()),
  );
}