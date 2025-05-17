import 'env_development.dart' as env; // Đổi thành env_production.dart cho production

class AppEnv {
  static final String baseUrl = env.Env.baseUrl;
}