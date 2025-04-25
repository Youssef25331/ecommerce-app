import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:college_ecommerce_app/controllers/user_service.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class registerPage extends StatelessWidget {
  const registerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 133, left: 32, right: 32),
        child: LoginHandler(),
      ),
    );
  }
}

class LoginHandler extends StatefulWidget {
  const LoginHandler({super.key});

  @override
  State<LoginHandler> createState() => _LoginHandlerState();
}

class _LoginHandlerState extends State<LoginHandler> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  List<User> _users = [];
  bool _obscureText = true;
  bool _confirmObscureText = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final users = await _userService.readUsers();
    setState(() {
      _users = users;
    });
  }

  Future<void> _addUser() async {
    final password = _passwordController.text;
    final email = _emailController.text;
    final name = email.split('@').first;

    final newUser = User(
      name: name,
      email: email,
      password: password,
      wishlist: [],
      cart: [],
    );
    setState(() {
      _users.add(newUser);
    });
    await _userService.writeUsers(_users);
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Create an account and join us',
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
                Row(
                  children: [
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 248,
                      height: 32,
                      child: TextFormField(
                        controller: _emailController,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Email address',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(top: 6),
                          isDense: true,
                          errorStyle: TextStyle(
                            color:
                                AppColors.error, // Use your app's error color
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
                      height: 23.0,
                      width: 23.0,
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 11),
                        SizedBox(
                          width: 150,
                          height: 31,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            style: const TextStyle(fontSize: 13),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(top: 5),
                              isDense: true,
                              errorStyle: TextStyle(
                                color: AppColors.error,
                                fontSize: 11,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 5) {
                                return 'Password must be at least 5 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap:
                      () => setState(() {
                        _obscureText = !_obscureText;
                      }),
                  child: SvgPicture.asset(
                    _obscureText
                        ? 'assets/icons/login/Light_Eye.svg'
                        : 'assets/icons/Light_Eye_Closed.svg',
                    height: _obscureText ? 24.0 : 28,

                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColors.thickEdges),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/login/Light_Lock.svg',
                        height: 24.0,
                        width: 24.0,
                        color: AppColors.textSecondary,
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 150,
                            height: 32,
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _confirmObscureText,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(top: 6),
                                isDense: true,
                                errorStyle: TextStyle(
                                  color: AppColors.error,
                                  fontSize: 12,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                if (value != _passwordController.text) {
                                  return 'Password doesn\'t match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap:
                      () => setState(() {
                        _confirmObscureText = !_confirmObscureText;
                      }),
                  child: SvgPicture.asset(
                    _confirmObscureText
                        ? 'assets/icons/login/Light_Eye.svg'
                        : 'assets/icons/Light_Eye_Closed.svg',
                    height: _confirmObscureText ? 24.0 : 28,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SigninButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String email = _emailController.text.trim();
                String password = _passwordController.text;
                print('Register attempt: Email: $email, Password: $password');
                _addUser();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Text('New user created successfully'),
                  ),
                );

                print(_users.last.email);
              } else {
                print('Validation failed');
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
              const Text(
                "Already have an account? ",
                style: TextStyle(color: AppColors.textSecondary),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SigninButton extends StatefulWidget {
  final VoidCallback onPressed;
  const SigninButton({super.key, required this.onPressed});

  @override
  State<SigninButton> createState() => _SigninButtonState();
}

class _SigninButtonState extends State<SigninButton> {
  bool _isHeld = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHighlightChanged: (isHighlighted) {
        setState(() {
          _isHeld = isHighlighted;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: _isHeld ? AppColors.primaryVariant : AppColors.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          textAlign: TextAlign.center,
          'Register',
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
