import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_colors.dart';
import '../auth/auth_bloc.dart';
import '../auth/auth_event.dart';
import '../auth/auth_state.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {
  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppColors.background,

      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor:
                  AppColors.success,
                ),
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
          },

          builder: (context, state) {
            final loading =
            state is AuthLoading;

            return SingleChildScrollView(
              padding:
              const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.stretch,

                children: [
                  const SizedBox(height: 50),

                  const Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight:
                      FontWeight.bold,
                      color:
                      AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Create your account to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                      AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 40),

                  _field(
                    nameController,
                    'Full Name',
                  ),

                  const SizedBox(height: 16),

                  _field(
                    emailController,
                    'Email',
                    keyboard:
                    TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  _field(
                    passwordController,
                    'Password',
                    obscure: true,
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                      context
                          .read<AuthBloc>()
                          .add(
                        SignupEvent(
                          name:
                          nameController
                              .text,
                          email:
                          emailController
                              .text,
                          password:
                          passwordController
                              .text,
                        ),
                      );
                    },

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      AppColors.primary,
                      foregroundColor:
                      AppColors.white,
                      minimumSize:
                      const Size(
                        double.infinity,
                        54,
                      ),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),

                    child: loading
                        ? const SizedBox(
                      height: 22,
                      width: 22,
                      child:
                      CircularProgressIndicator(
                        color:
                        AppColors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      'Create Account',
                    ),
                  ),

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
                      backgroundColor:
                      AppColors.white,
                      side: const BorderSide(
                        color:
                        AppColors.border,
                      ),
                    ),

                    icon: const Icon(
                      Icons.g_mobiledata,
                      color:
                      AppColors.google,
                    ),

                    label: const Text(
                      'Continue with Google',
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child:
                        const Text('Login'),
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

  Widget _field(
      TextEditingController controller,
      String hint, {
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
}