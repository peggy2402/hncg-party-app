import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hncgparty/features/auth/domain/usecases/login_usecase.dart';
import 'package:hncgparty/features/auth/presentation/blocs/auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested); // Event name must match
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    final result = await loginUseCase.call(event.email, event.password);
    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (userEntity) => emit(AuthAuthenticated(user: userEntity)), // Use correct state
    );
  }
}
