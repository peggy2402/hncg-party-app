import 'package:hncg_app/core/utils/typedef.dart';
import 'package:hncg_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  ResultVoid call() async {
    return await _repository.logout();
  }
}