import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/registration/login/login_cubit.dart';
import 'package:my_smartstore/registration/login/login_state.dart';
import 'package:my_smartstore/registration/sign_up/sign_up_screen.dart';

import '../../constants.dart';

class LoginScreen extends StatelessWidget {
 final formkey = GlobalKey<FormState>();
 late String email_phone,password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: BlocConsumer<LoginCubit,LoginState>(
              listener: (context,state){},
              builder: (context,state)=>Column(
                children: [
                  const SizedBox(height: 28,),
                  Image.asset('assets/images/logo.png',height: 100,),
                  const SizedBox(height: 48,),
                  if(state is LoginSubmitting)
                    const CircularProgressIndicator(),
                  const SizedBox(height: 28,),
                  ElevatedButton(
                      style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>
                        (RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)
                      ),
                      ),
                          elevation: MaterialStateProperty.all(0),
                          fixedSize: MaterialStateProperty.all(const Size(
                              double.maxFinite, 50))
                      ),
                      onPressed: (state is LoginSubmitting)? null:(){
                        if(formkey.currentState!.validate()){
                          BlocProvider.of<LoginCubit>(context).login(email_phone, password);
                        }
                      },
                      child:const Text('Login') ),
                  const SizedBox(
                    height: 48,),
                  TextButton(onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>SignUpScreen())
                    );

                  }, child: const Text('Don\'t have an account ?Sign Up!'))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 Widget _emailphonefield(enableFrom,error){
   return TextFormField(
     enabled: enableFrom,
     validator: (value){
       if(value!.isEmpty){
         return "Required!";
       }
       if(value.length<4){
         return ('Invalid credentials');
       }
       email_phone = value;
     },
     style: TextStyle(fontSize: 14),
     decoration: InputDecoration(
         enabledBorder: ENABLED_BORDER,
         contentPadding:EdgeInsets.symmetric(horizontal: 16,vertical: 16),
         focusedBorder: FOCUSED_BORDER,
         errorBorder: ERROR_BORDER,
         focusedErrorBorder: FOCUSED_BORDER,
         errorText: error,
         errorStyle: TextStyle(height: 1),
         hintText: "Email or Phone no.",
         labelText:"Email or Phone no.",
         suffixIcon: const Icon(Icons.account_circle)
     ),
   );
 }

 Widget _passwordField(enableFrom,error){
   return TextFormField(
     enabled: enableFrom,
     obscureText: true,
     validator: (value){
       if(value!.isEmpty){
         return "Required!";
       }
       if(value!.length <8){
         return "Incorrect password!";
       }
       password = value;
     },
     style: TextStyle(fontSize: 14),
     decoration: InputDecoration(
         enabledBorder: ENABLED_BORDER,
         contentPadding:EdgeInsets.symmetric(horizontal: 16,vertical: 16),
         focusedBorder: FOCUSED_BORDER,
         errorBorder: ERROR_BORDER,
         focusedErrorBorder: FOCUSED_BORDER,
         errorText: error,
         errorStyle: TextStyle(height: 1),
         hintText: "Enter Your Password",
         labelText:"Password : ",
         suffixIcon: const Icon(Icons.lock)
     ),
   );
 }
}
