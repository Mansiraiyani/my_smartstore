import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/registration/sign_up/signup_cubit.dart';
import 'package:my_smartstore/registration/sign_up/signup_state.dart';

import '../../constants.dart';

class SignUpScreen extends StatelessWidget {
  late String _email;
  late String _name;
  late String _phone;
  late String _password;
  late String _confirmpassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  Image.asset(
                    'assets/images/logo.webp',
                    height: 80,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  _emailField(state is! SignUpSubmitting,
                      state is SignUpFailed ? state.message : null),
                  const SizedBox(
                    height: 24,
                  ),
                  _phoneField(state is! SignUpSubmitting,
                      state is SignUpFailed ? state.message : null),
                  const SizedBox(
                    height: 24,
                  ),
                  _nameField(state is! SignUpSubmitting),
                  const SizedBox(
                    height: 24,
                  ),
                  _passwordField(state is! SignUpSubmitting),
                  const SizedBox(
                    height: 24,
                  ),
                  _confirmpasswordField(state is! SignUpSubmitting),
                  const SizedBox(
                    height: 28,
                  ),
                  if (state is SignUpSubmitting) const CircularProgressIndicator(),
                  const SizedBox(
                    height: 28,
                  ),
                  ElevatedButton(
                      onPressed: (state is SignUpSubmitting) ? null : () {},
                      child: const Text('Create Account'))
                ],
              );
            },
          ),
        ),
      ),
    ));
  }

  Widget _emailField(enableFrom, error) {
    return TextFormField(
      enabled: enableFrom,
      validator: (value) {
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!)) {
          return "Please enter a valid Email Address";
        }
        _email = value;
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter Your Email Address",
          labelText: "Email Address : ",
          suffixIcon: const Icon(Icons.email)),
    );
  }

  Widget _phoneField(enableFrom, error) {
    return TextFormField(
      maxLength: 10,
      enabled: enableFrom,
      validator: (value) {
        if (value!.length != 10) {
          return "Please enter a valid Phone Number";
        }
        _phone = value;
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 14),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter Your Phone Number",
          labelText: "Phone : ",
          suffixIcon: const Icon(Icons.smartphone)),
    );
  }

  Widget _nameField(enableFrom) {
    return TextFormField(
      enabled: enableFrom,
      validator: (value) {
        if (value!.length <= 1) {
          return "Please enter a valid Name";
        }
        _name = value;
        return null;
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter Your Name",
          labelText: "FullName : ",
          suffixIcon: const Icon(Icons.email)),
    );
  }

  Widget _passwordField(enableFrom) {
    return TextFormField(
      enabled: enableFrom,
      obscureText: true,
      validator: (value) {
        if (value!.length < 8) {
          return "at least 8 character";
        }
        _password = value;
        return null;
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter Your Password",
          labelText: "Password : ",
          suffixIcon: const Icon(Icons.lock)),
    );
  }

  Widget _confirmpasswordField(enableFrom) {
    return TextFormField(
      enabled: enableFrom,
      obscureText: true,
      validator: (value) {
        if (value != _password) {
          return "password mismatched!";
        }
        _confirmpassword = value!;
        return null;
      },
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: const TextStyle(height: 1),
          hintText: "Enter Your Confirm Password",
          labelText: "Confirm Password : ",
          suffixIcon: const Icon(Icons.lock)),
    );
  }
}
