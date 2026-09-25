
class AuthRepository {
  // =========================
  // EMAIL LOGIN
  // =========================

  Future<void> loginEmail(
      String email,
      String password,
      ) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (email.trim().isEmpty) {
      throw Exception('Email is required');
    }

    if (password.isEmpty) {
      throw Exception('Password is required');
    }

    // Temporary login
    return;
  }

  // =========================
  // SIGNUP
  // =========================

  Future<void> signup(
      String name,
      String email,
      String password,
      ) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (name.trim().isEmpty) {
      throw Exception('Name is required');
    }

    if (email.trim().isEmpty) {
      throw Exception('Email is required');
    }

    if (password.isEmpty) {
      throw Exception('Password is required');
    }

    // Temporary signup
    return;
  }

  // =========================
  // GOOGLE LOGIN
  // =========================

  Future<void> googleLogin() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    // Temporary Google login
    return;
  }

  // =========================
  // SEND OTP
  // =========================

  Future<void> sendOtp({
    required String phone,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (phone.trim().isEmpty) {
      onError('Phone number is required');
      return;
    }

    // Temporary verification ID
    onCodeSent('temporary_verification_id');
  }

  // =========================
  // VERIFY OTP
  // =========================

  Future<void> verifyOtp(
      String verificationId,
      String otp,
      ) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (otp.length != 6) {
      throw Exception('Please enter a valid 6 digit OTP');
    }

    // Temporary OTP verification
    return;
  }
}