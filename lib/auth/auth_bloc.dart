import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_repositories.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginEmailEvent>(_loginEmail);
    on<SignupEvent>(_signup);
    on<GoogleLoginEvent>(_googleLogin);
    on<SendOtpEvent>(_sendOtp);
    on<VerifyOtpEvent>(_verifyOtp);
  }

  // =========================
  // EMAIL LOGIN
  // =========================

  Future<void> _loginEmail(
      LoginEmailEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await repository.loginEmail(
        event.email,
        event.password,
      );

      emit(
        AuthSuccess('Login successful'),
      );
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }

  // =========================
  // SIGNUP
  // =========================

  Future<void> _signup(
      SignupEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await repository.signup(
        event.name,
        event.email,
        event.password,
      );

      emit(
        AuthSuccess('Account created successfully'),
      );
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }

  // =========================
  // GOOGLE LOGIN
  // =========================

  Future<void> _googleLogin(
      GoogleLoginEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await repository.googleLogin();

      emit(
        AuthSuccess('Google login successful'),
      );
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }

  // =========================
  // SEND OTP
  // =========================

  Future<void> _sendOtp(
      SendOtpEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await repository.sendOtp(
        phone: event.phone,
        onCodeSent: (verificationId) {
          emit(
            OtpSent(verificationId),
          );
        },
        onError: (error) {
          emit(
            AuthFailure(error.toString()),
          );
        },
      );
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }

  // =========================
  // VERIFY OTP
  // =========================

  Future<void> _verifyOtp(
      VerifyOtpEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await repository.verifyOtp(
        event.verificationId,
        event.otp,
      );

      emit(
        AuthSuccess('Phone login successful'),
      );
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }
}