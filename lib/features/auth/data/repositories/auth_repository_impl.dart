import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.login(
      email: email,
      password: password,
    );

    await localDataSource.cacheAuthToken(response.token);
    await localDataSource.cacheUserData(response.user);

    return response.toEntity();
  }

  @override
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String username,
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    final response = await remoteDataSource.register(
      email: email,
      password: password,
      username: username,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    );

    await localDataSource.cacheAuthToken(response.token);
    await localDataSource.cacheUserData(response.user);

    return response.toEntity();
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.clearCache();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await remoteDataSource.resetPassword(email: email);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }

  @override
  @override
  Future<void> sendOtp({required String phone}) async {
    await remoteDataSource.sendOtp(phone: phone);
  }

  @override
  Future<bool> verifyOtp({required String phone, required String otp}) async {
    return await remoteDataSource.verifyOtp(phone: phone, otp: otp);
  }

  @override
  Future<AppUser> getProfile() async {
    final userModel = await remoteDataSource.getProfile();

    await localDataSource.cacheUserData(userModel);

    return userModel.toEntity();
  }

  @override
  Future<AppUser> updateProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    final userModel = await remoteDataSource.updateProfile(
      username: username,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    );

    await localDataSource.cacheUserData(userModel);

    return userModel.toEntity();
  }

  @override
  Future<void> registerFcmToken({required String token}) async {
    await remoteDataSource.registerFcmToken(token: token);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final userModel = await localDataSource.getCachedUserData();
    return userModel?.toEntity();
  }

  @override
  Future<String?> getAuthToken() async {
    return await localDataSource.getAuthToken();
  }
}
