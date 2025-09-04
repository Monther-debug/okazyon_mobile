import 'user.dart';

class AuthResponse {
  final User user;
  final String token;

  const AuthResponse({required this.user, required this.token});
}
