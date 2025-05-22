import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hncgparty/features/auth/domain/usecases/login_usecase.dart';
import 'package:hncgparty/features/auth/domain/usecases/signup_usecase.dart'; // Thêm dòng này
import 'package:hncgparty/features/auth/presentation/blocs/auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase; // Thêm SignupUseCase

  AuthBloc({
    required this.loginUseCase,
    required this.signupUseCase, // Thêm vào constructor
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested); // Thêm xử lý sự kiện mới
  }

  // Xử lý đăng nhập
  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    final result = await loginUseCase.call(event.usernameOrEmail, event.password);
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (userEntity) => emit(AuthAuthenticated(user: userEntity, flag: false)),
    );
  }

  // Xử lý đăng ký
  Future<void> _onSignupRequested(
      SignupRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    final result = await signupUseCase.call(
      event.username,
      event.email,
      event.password,
    );
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (userEntity) => emit(AuthAuthenticated(user: userEntity, flag: true)),
    );
  }
}