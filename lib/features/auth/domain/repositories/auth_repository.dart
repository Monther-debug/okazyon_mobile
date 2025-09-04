import '../entities/auth_response.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<AuthResponse> login({required String email, required String password});

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String username,
    String? firstName,
    String? lastName,
    String? phone,
  });

  Future<void> logout();

  Future<void> resetPassword({required String email});

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<void> sendOtp({required String phone});

  Future<bool> verifyOtp({required String phone, required String otp});

  Future<User> getProfile();

  Future<User> updateProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? phone,
  });

  Future<void> registerFcmToken({required String token});

  Future<bool> isLoggedIn();
  Future<User?> getCurrentUser();
  Future<String?> getAuthToken();
}
