import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:college_ecommerce_app/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 133, left: 32, right: 32),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Good to see you again!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: AppColors.thickEdges),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/login/Light_User.svg',
                      color: AppColors.textSecondary,
                      height: 24.0,
                      width: 24.0,
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 248,
                      height: 32,
                      child: TextFormField(
                        controller: _emailController,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Email address',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 6),
                          isDense: true,
                          errorStyle: TextStyle(
                            color: AppColors.error,
                            fontSize: 12,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: AppColors.thickEdges),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/login/Light_Lock.svg',
                          color: AppColors.textSecondary,
                          height: 22.0,
                          width: 22.0,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 148,
                          height: 30,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true, // Simplified, can add toggle if needed
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 4),
                              isDense: true,
                              errorStyle: TextStyle(
                                color: AppColors.error,
                                fontSize: 10,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 4) {
                                return 'Password must be at least 4 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    // Add eye toggle if needed
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SigninButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await userViewModel.login(
                      _emailController.text.trim(),
                      _passwordController.text,
                    );
                    if (success) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.error,
                          content: Text(userViewModel.errorMessage ?? 'Login failed'),
                        ),
                      );
                    }
                    _emailController.clear();
                    _passwordController.clear();
                  }
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(height: 1, color: AppColors.thickEdges),
                  ),
                  const SizedBox(width: 12),
                  const Text('or', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(height: 1, color: AppColors.thickEdges),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class SigninButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SigninButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          textAlign: TextAlign.center,
          'Sign in',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
