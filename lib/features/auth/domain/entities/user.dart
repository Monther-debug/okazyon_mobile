class User {
  final String id;
  final String email;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.phone,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return username ?? email;
  }
}

class AuthToken {
  final String accessToken;
  final String tokenType;

  const AuthToken({required this.accessToken, required this.tokenType});
}

class AuthResponse {
  final User user;
  final AuthToken token;

  const AuthResponse({required this.user, required this.token});
}
