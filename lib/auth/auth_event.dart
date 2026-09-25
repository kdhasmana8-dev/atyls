abstract class AuthEvent {}

class LoginEmailEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEmailEvent({
    required this.email,
    required this.password,
  });
}

class SignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignupEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class GoogleLoginEvent extends AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String phone;

  SendOtpEvent({
    required this.phone,
  });
}

class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String otp;

  VerifyOtpEvent({
    required this.verificationId,
    required this.otp,
  });
}