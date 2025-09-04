import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// OTP State
class OtpState {
  final int timerValue;
  final bool isTimerActive;
  final bool isLoading;
  final String? error;

  const OtpState({
    this.timerValue = 60,
    this.isTimerActive = true,
    this.isLoading = false,
    this.error,
  });

  OtpState copyWith({
    int? timerValue,
    bool? isTimerActive,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return OtpState(
      timerValue: timerValue ?? this.timerValue,
      isTimerActive: isTimerActive ?? this.isTimerActive,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

// OTP Controller
class OtpController extends StateNotifier<OtpState> {
  Timer? _timer;

  OtpController() : super(const OtpState()) {
    startTimer();
  }

  void startTimer() {
    state = state.copyWith(timerValue: 60, isTimerActive: true);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerValue > 0) {
        state = state.copyWith(timerValue: state.timerValue - 1);
      } else {
        state = state.copyWith(isTimerActive: false);
        timer.cancel();
      }
    });
  }

  Future<void> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, clearError: true);
    // TODO: Call the verify OTP use case from AuthController
    await Future.delayed(const Duration(seconds: 2));
    // Mock logic
    if (otp == '123456') {
      state = state.copyWith(isLoading: false);
      // Navigate to success or home
    } else {
      state = state.copyWith(isLoading: false, error: 'Invalid OTP code');
    }
  }

  Future<void> resendOtp(String phone) async {
    // TODO: Call the resend OTP use case from AuthController
    startTimer();
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Provider
final otpControllerProvider =
    StateNotifierProvider.autoDispose<OtpController, OtpState>(
      (ref) => OtpController(),
    );
