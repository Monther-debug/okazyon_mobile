class AppConfig {
  static const String baseUrl = 'http://127.0.0.1:8003/';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  static const String loginEndpoint = 'api/v1/login';
  static const String registerEndpoint = 'api/v1/register';
  static const String resetPasswordEndpoint = 'api/v1/reset-password';
  static const String logoutEndpoint = 'api/v1/logout';
  static const String sendOtpEndpoint = 'api/v1/sendotp';
  static const String verifyOtpEndpoint = 'api/v1/verifyotp';
  static const String fcmTokenEndpoint = 'api/v1/fcm-token';
  static const String profileEndpoint = 'api/v1/profile';
  static const String changePasswordEndpoint = 'api/v1/change-password';
}
