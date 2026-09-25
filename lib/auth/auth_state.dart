abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess(this.message);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class OtpSent extends AuthState {
  final String verificationId;

  OtpSent(this.verificationId);
}