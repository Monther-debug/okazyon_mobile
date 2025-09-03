class AppConfig {
  static const String baseUrl =
      'https://your-api-domain.com/api'; // Replace with your actual API URL
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // API Endpoints
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';
  static const String resetPasswordEndpoint = '/reset-password';
  static const String logoutEndpoint = '/logout';
  static const String sendOtpEndpoint = '/sendotp';
  static const String verifyOtpEndpoint = '/verifyotp';
  static const String fcmTokenEndpoint = '/fcm-token';
  static const String profileEndpoint = '/profile';
  static const String changePasswordEndpoint = '/change-password';
}
