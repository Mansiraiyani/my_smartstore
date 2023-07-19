import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/registration/otp/otp_cubit.dart';
import 'package:my_smartstore/registration/sign_up/signup_cubit.dart';
import 'package:my_smartstore/registration/sign_up/signup_state.dart';

import '../../constants.dart';
import '../login/login_screen.dart';
import '../otp/otp_screen.dart';

class SignUpScreen extends StatelessWidget {

  final formkey = GlobalKey<FormState>();
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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              child: BlocConsumer<SignUpCubit,SignUpState>(
                listener:(context,state) {
                  if(state is SignUpSuccess){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>BlocProvider<OtpCubit>(create:(_)=>OtpCubit(),child: OtpScreen(_email,_phone,_name,_password)))
                    );
                  }
                  if(state is SignUpFailed){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(state.message!),backgroundColor: Colors.red,));
                  }

                },
                builder:(context,state){
                  return Column(
                    children: [
                      SizedBox(height: 28,),
                      Image.asset('assets/images/logo.png',height: 100,),
                      SizedBox(height: 48,),
                      _emailField(!(state is SignUpSubmitting),state is SignUpFailed?state.message == 'email already exists'?state.message:null:null),
                      SizedBox(height: 24,),
                      _phoneField(!(state is SignUpSubmitting),state is SignUpFailed?state.message == 'phone already exists'?state.message:null:null),
                      SizedBox(height: 24,),
                      _nameField(!(state is SignUpSubmitting)),
                      SizedBox(height: 24,),
                      _passwordField(!(state is SignUpSubmitting)),
                      SizedBox(height: 24,),
                      _confirmpasswordField(!(state is SignUpSubmitting)),
                      SizedBox(height: 28,),
                      if(state is SignUpSubmitting)
                        CircularProgressIndicator(),
                      SizedBox(height: 28,),
                      ElevatedButton(
                        style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>
                          (RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)
                        ),
                        ),
                          elevation: MaterialStateProperty.all(0),
                          fixedSize: MaterialStateProperty.all(Size(
                              double.maxFinite, 50))
                        ),
                          onPressed: (state is SignUpSubmitting)? null:(){
                        if(formkey.currentState!.validate()){
                          BlocProvider.of<SignUpCubit>(context).requestotp(_email, _phone);
                        }
                      },
                          child:Text('Create Account') ),
                      SizedBox(
                        height: 48,),
                      TextButton(onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                        );

                      }, child: Text('Already have anaccount?Login'))
                      

                    ],
                  );
                },
              ),
            ),
          ),
        ),
      )
    );
  }
  Widget _emailField(enableFrom,error){
    return TextFormField(
      enabled: enableFrom,
      validator: (value){
        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!)){
          return "Please enter a valid Email Address";
        }
        _email = value;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        enabledBorder: ENABLED_BORDER,
        contentPadding:EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        focusedBorder: FOCUSED_BORDER,
        errorBorder: ERROR_BORDER,
        focusedErrorBorder: FOCUSED_BORDER,
        errorText: error,
        errorStyle: TextStyle(height: 1),
        hintText: "Enter Your Email Address",
        labelText:"Email Address : ",
        suffixIcon: const Icon(Icons.email)
      ),
    );
  }


  Widget _phoneField(enableFrom,error){
    return TextFormField(
      maxLength: 10,
      enabled: enableFrom,
      validator: (value){
        if(value!.length != 10){
          return "Please enter a valid Phone Number";
        }
        _phone = value;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 14),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorText: error,
          errorStyle: TextStyle(height: 1),
          hintText: "Enter Your Phone Number",
          labelText:"Phone : ",
          suffixIcon: const Icon(Icons.smartphone)
      ),
    );
  }

  Widget _nameField(enableFrom){
    return TextFormField(
      enabled: enableFrom,
      validator: (value){
        if(value!.length <= 1){
          return "Please enter a valid Name";
        }
        _name = value;
      },
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: TextStyle(height: 1),
          hintText: "Enter Your Name",
          labelText:"FullName : ",
          suffixIcon: const Icon(Icons.email)
      ),
    );
  }

  Widget _passwordField(enableFrom){
    return TextFormField(
      enabled: enableFrom,
      obscureText: true,
      validator: (value){
        if(value!.length <8){
          return "at least 8 character";
        }
        _password = value;
      },
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: TextStyle(height: 1),
          hintText: "Enter Your Password",
          labelText:"Password : ",
          suffixIcon: const Icon(Icons.lock)
      ),
    );
  }

  Widget _confirmpasswordField(enableFrom){
    return TextFormField(
      enabled: enableFrom,
      obscureText: true,
      validator: (value){
        if(value != _password){
          return "password mismatched!";
        }
        _confirmpassword = value!;
      },
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          enabledBorder: ENABLED_BORDER,
          contentPadding:EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          focusedBorder: FOCUSED_BORDER,
          errorBorder: ERROR_BORDER,
          focusedErrorBorder: FOCUSED_BORDER,
          errorStyle: TextStyle(height: 1),
          hintText: "Enter Your Confirm Password",
          labelText:"Confirm Password : ",
          suffixIcon: const Icon(Icons.lock)
      ),
    );
  }
}
