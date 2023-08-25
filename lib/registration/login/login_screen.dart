import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/home/home_screen.dart';
import 'package:my_smartstore/registration/forgot_password/forgot_password_screen.dart';
import 'package:my_smartstore/registration/login/login_cubit.dart';
import 'package:my_smartstore/registration/login/login_state.dart';
import 'package:my_smartstore/registration/sign_up/sign_up_screen.dart';

import '../../constants.dart';
import '../authentication/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  late String email_phone, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formkey,
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    BlocProvider.of<AuthCubit>(context).loggedIn(state.token);
                    Navigator.pop(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => HomeScreen(),
                    //     ));
                  }
                  if (state is LoginFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                builder: (context, state) => Column(
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    _emailphonefield(
                        !(state is LoginSubmitting),
                        state is LoginFailed
                            ? state.message == "incorrect password"
                                ? null
                                : state.message
                            : null),
                    const SizedBox(
                      height: 24,
                    ),
                    _passwordField(
                        !(state is LoginSubmitting),
                        state is LoginFailed
                            ? state.message != "incorrect password"
                                ? null
                                : state.message
                            : null),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        child: const Text("Forgot Password?"),
                        onPressed: state is LoginSubmitting
                            ? null
                            : () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ForgotPasswordScreen()));
                              },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    if (state is LoginSubmitting)
                      const CircularProgressIndicator(),
                    const SizedBox(
                      height: 28,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            elevation: MaterialStateProperty.all(0),
                            fixedSize: MaterialStateProperty.all(
                                const Size(double.maxFinite, 50))),
                        onPressed: (state is LoginSubmitting)
                            ? null
                            : () {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<LoginCubit>(context)
                                      .login(email_phone, password);
                                }
                              },
                        child: const Text('Login')),
                    const SizedBox(
                      height: 48,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Don\'t have an account ?Sign Up!'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailphonefield(enableFrom, error) {
    return TextFormField(
      enabled: enableFrom,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required!";
        }
        if (value.length < 4) {
          return ('Invalid credentials');
        }
        email_phone = value;
      },
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: TextStyle(height: 1),
          hintText: "Email or Phone no.",
          labelText: "Email or Phone no.",
          suffixIcon: const Icon(Icons.account_circle)),
    );
  }

  Widget _passwordField(enableFrom, error) {
    return TextFormField(
      enabled: enableFrom,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required!";
        }
        if (value.length < 8) {
          return "Incorrect password!";
        }
        password = value;
      },
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: TextStyle(height: 1),
          hintText: "Enter Your Password",
          labelText: "Password : ",
          suffixIcon: const Icon(Icons.lock)),
    );
  }
}
