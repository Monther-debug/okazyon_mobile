# Laravel API Integration Setup

## 🚀 Setup Instructions

### 1. Update API Base URL
In `lib/core/network/app_config.dart`, replace the base URL with your actual Laravel API URL:

```dart
static const String baseUrl = 'https://your-actual-domain.com/api';
```

### 2. API Endpoints Mapped
Your Laravel routes are now mapped to Flutter:

- `POST /login` → Login functionality
- `POST /register` → Registration functionality  
- `POST /logout` → Logout functionality
- `POST /reset-password` → Password reset
- `POST /sendotp` → Send OTP
- `POST /verifyotp` → Verify OTP
- `GET /profile` → Get user profile
- `PUT /profile` → Update user profile
- `POST /change-password` → Change password
- `POST /fcm-token` → Register FCM token

### 3. Authentication Flow
The app now uses a complete authentication flow:

1. **Login/Register** → Receives token + user data
2. **Token Storage** → Automatically stored in SharedPreferences  
3. **Auto-Auth Headers** → Token automatically added to requests
4. **Token Refresh** → Handles 401 responses
5. **Logout** → Clears local storage

### 4. Error Handling
The app handles different types of errors:

- **Network Errors** → Connection timeouts, no internet
- **API Errors** → Server responses with error messages
- **Validation Errors** → Laravel validation errors (422 status)

### 5. Usage in UI
Your existing UI components now work with real API:

```dart
// Login
await ref.read(authControllerProvider.notifier).login(email, password);

// Register  
await ref.read(authControllerProvider.notifier).signup(
  username: username,
  email: email, 
  password: password,
  // ... other fields
);

// Logout
await ref.read(authControllerProvider.notifier).logout();
```

### 6. Data Flow Architecture

```
UI (Screens) 
↓
Controllers (Riverpod StateNotifier)
↓  
Use Cases (Business Logic)
↓
Repository (Interface)
↓
Repository Implementation 
↓
Data Sources (Remote API + Local Storage)
```

### 7. Features Included

✅ **Clean Architecture** - Proper separation of concerns
✅ **State Management** - Riverpod for reactive UI
✅ **API Integration** - Dio HTTP client with interceptors  
✅ **Token Management** - Automatic token handling
✅ **Error Handling** - Comprehensive error management
✅ **Local Storage** - User data caching
✅ **Loading States** - UI feedback during operations
✅ **Validation** - Form validation with server errors

### 8. Laravel Response Format Expected

**Login/Register Response:**
```json
{
  "user": {
    "id": "1",
    "email": "user@example.com", 
    "username": "johndoe",
    "first_name": "John",
    "last_name": "Doe",
    "phone": "+1234567890",
    "email_verified_at": "2023-01-01T00:00:00Z",
    "created_at": "2023-01-01T00:00:00Z",
    "updated_at": "2023-01-01T00:00:00Z"
  },
  "token": {
    "access_token": "your-jwt-token-here",
    "token_type": "Bearer"
  }
}
```

**Error Response:**
```json
{
  "message": "The given data was invalid.",
  "errors": {
    "email": ["The email field is required."],
    "password": ["The password field is required."]
  }
}
```

### 9. Next Steps

1. **Test API Connection** - Update base URL and test login
2. **Add OTP Screens** - Create OTP verification UI
3. **Add Profile Screen** - User profile management
4. **Add Password Reset** - Forgot password flow
5. **Add FCM Integration** - Push notifications

Your Flutter app is now ready to work with your Laravel API! 🎉
