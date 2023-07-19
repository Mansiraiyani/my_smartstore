import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {


  final String _email,_password,_name,_phone;
  late String _otp;
  late bool onlyverify;

  OtpScreen(this._email, this._password, this._name, this._phone,{this.onlyverify=false});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Image.asset("assets/images/otp.png",height: 100,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
