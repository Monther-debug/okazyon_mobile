import 'user.dart';

class AuthResponse {
  final AppUser user;
  final String token;

  const AuthResponse({required this.user, required this.token});
}
