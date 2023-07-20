import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/home/home_screen.dart';
import 'package:my_smartstore/registration/authentication/auth_cubit.dart';
import 'package:my_smartstore/registration/otp/otp_cubit.dart';
import 'package:my_smartstore/registration/otp/otp_state.dart';

import '../../constants.dart';

class OtpScreen extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  final String _email, _password, _name, _phone;
  late String _otp;
  late bool onlyverify;
  var timer;
  int time = 0;

  OtpScreen(this._email, this._password, this._name, this._phone,
      {this.onlyverify = false});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: widget.formKey,
              child:
                  BlocConsumer<OtpCubit, OtpState>(listener: (context, state) {
                if (state is OtpVerified) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                  if (widget.onlyverify) {
                    //todo only verify
                  } else {
                    BlocProvider.of<AuthCubit>(context).loggedIn(state.token);
                    Navigator.pop(context);
                  }
                }
                if (state is OtpVerificationFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message!),
                    backgroundColor: Colors.red,
                  ));
                }
              }, builder: (context, state) {
                return Column(
                  children: [
                    Image.asset(
                      "assets/images/otp.png",
                      height: 100,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Phone Verification',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                        'A verification code has been successfully sent your phone no.'),
                    SizedBox(
                      height: 48,
                    ),
                    _otpField(!(state is OtpVerifying),
                        state is OtpVerificationFailed ? state.message : null),
                    SizedBox(
                      height: 24,
                    ),
                    TextButton(
                        child: Text(widget.time != 0
                            ? "Wait for ${widget.time} seconds to resend "
                            : 'Resend'),
                        onPressed: widget.time != 0
                            ? null
                            : () {
                                BlocProvider.of<OtpCubit>(context)
                                    .resendOtp(phone: widget._phone);
                                startTimer();
                              }),
                    if (state is OtpVerifying) CircularProgressIndicator(),
                    SizedBox(
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
                                Size(double.maxFinite, 50))),
                        onPressed: state is OtpVerifying
                            ? null
                            : () {
                                if (widget.formKey.currentState!.validate()) {
                                  if (widget.onlyverify) {
                                  } else {
                                    BlocProvider.of<OtpCubit>(context)
                                        .verifyotp(
                                            email: widget._email,
                                            name: widget._name,
                                            password: widget._password,
                                            phone: widget._phone,
                                            otp: widget._otp);
                                  }
                                }
                              },
                        child: Text('Verify')),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpField(enableFrom, error) {
    return TextFormField(
      maxLength: 6,
      enabled: enableFrom,
      validator: (value) {
        if (value!.length != 6) {
          return "Invalid OTP";
        }
        widget._otp = value;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 14),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: TextStyle(height: 1),
          hintText: "Enter 6 digit varification code",
          labelText: "Verification Otp : ",
          suffixIcon: const Icon(Icons.sms)),
    );
  }

  void startTimer() {
    widget.time = 60;
    const onesec = const Duration(seconds: 1);
    widget.timer = Timer.periodic(onesec, (timer) {
      if (widget.time == 0) {
        timer.cancel();
      } else {
        setState(() {
          widget.time = widget.time - 1;
        });
      }
    });
  }
}
