import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_colors.dart';
import '../auth/auth_bloc.dart';
import '../auth/auth_event.dart' show GoogleLoginEvent, LoginEmailEvent, SendOtpEvent, VerifyOtpEvent;
import '../auth/auth_state.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  bool phoneLogin = false;
  String? verificationId;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                    (route) => false,
              );
            }

            if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor:
                  AppColors.error,
                ),
              );
            }

            if (state is OtpSent) {
              setState(() {
                verificationId =
                    state.verificationId;
              });

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                    'OTP sent successfully',
                  ),
                ),
              );
            }
          },

          builder: (context, state) {
            final loading =
            state is AuthLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.stretch,

                children: [
                  const SizedBox(height: 50),

                  const Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color:
                      AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Login to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                      AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 40),

                  if (!phoneLogin)
                    _emailLogin(loading)
                  else
                    _phoneLogin(loading),

                  const SizedBox(height: 20),

                  OutlinedButton.icon(
                    onPressed: loading
                        ? null
                        : () {
                      context
                          .read<AuthBloc>()
                          .add(
                        GoogleLoginEvent(),
                      );
                    },

                    style:
                    OutlinedButton.styleFrom(
                      minimumSize:
                      const Size(
                        double.infinity,
                        54,
                      ),
                      side: const BorderSide(
                        color:
                        AppColors.border,
                      ),
                      backgroundColor:
                      AppColors.white,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),

                    icon: const Icon(
                      Icons.g_mobiledata,
                      color: AppColors.google,
                      size: 30,
                    ),

                    label: const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color:
                        AppColors.textPrimary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        phoneLogin =
                        !phoneLogin;
                      });
                    },
                    child: Text(
                      phoneLogin
                          ? 'Login with Email'
                          : 'Login with Phone',
                      style: const TextStyle(
                        color:
                        AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors
                              .textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/signup',
                          );
                        },
                        child: const Text(
                          'Sign Up',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _emailLogin(bool loading) {
    return Column(
      children: [
        _field(
          controller: emailController,
          hint: 'Email',
          keyboard:
          TextInputType.emailAddress,
        ),

        const SizedBox(height: 16),

        _field(
          controller: passwordController,
          hint: 'Password',
          obscure: true,
        ),

        const SizedBox(height: 20),

        _loginButton(
          loading,
              () {
            context.read<AuthBloc>().add(
              LoginEmailEvent(
                email:
                emailController.text,
                password:
                passwordController.text,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _phoneLogin(bool loading) {
    return Column(
      children: [
        _field(
          controller: phoneController,
          hint: '+91XXXXXXXXXX',
          keyboard: TextInputType.phone,
        ),

        const SizedBox(height: 20),

        _loginButton(
          loading,
              () {
            context.read<AuthBloc>().add(
              SendOtpEvent(
                phone:
                phoneController.text,
              ),
            );
          },
          text: 'Send OTP',
        ),

        const SizedBox(height: 16),

        _field(
          controller: otpController,
          hint: 'Enter OTP',
          keyboard: TextInputType.number,
        ),

        const SizedBox(height: 20),

        _loginButton(
          loading,
          verificationId == null
              ? null
              : () {
            context
                .read<AuthBloc>()
                .add(
              VerifyOtpEvent(
                verificationId:
                verificationId!,
                otp:
                otpController.text,
              ),
            );
          },
          text: 'Verify OTP',
        ),
      ],
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    TextInputType? keyboard,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,

      decoration: InputDecoration(
        hintText: hint,

        filled: true,
        fillColor: AppColors.white,

        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _loginButton(
      bool loading,
      VoidCallback? onPressed, {
        String text = 'Login',
      }) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,

      style: ElevatedButton.styleFrom(
        backgroundColor:
        AppColors.primary,
        foregroundColor:
        AppColors.white,

        minimumSize:
        const Size(double.infinity, 54),

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),
      ),

      child: loading
          ? const SizedBox(
        height: 22,
        width: 22,
        child:
        CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.white,
        ),
      )
          : Text(text),
    );
  }
}