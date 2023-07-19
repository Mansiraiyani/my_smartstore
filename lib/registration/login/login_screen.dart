import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/registration/login/login_cubit.dart';
import 'package:my_smartstore/registration/login/login_state.dart';
import 'package:my_smartstore/registration/sign_up/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
 final formkey = GlobalKey<FormState>();
 late String emial_phone,password;

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
                  SizedBox(height: 28,),
                  Image.asset('assets/images/logo.png',height: 100,),
                  SizedBox(height: 48,),
                  if(state is LoginSubmitting)
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
                      onPressed: (state is LoginSubmitting)? null:(){
                        if(formkey.currentState!.validate()){
                          BlocProvider.of<LoginCubit>(context).login(emial_phone, password);
                        }
                      },
                      child:Text('Login') ),
                  SizedBox(
                    height: 48,),
                  TextButton(onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>SignUpScreen())
                    );

                  }, child: Text('Don\'t have an account ?Sign Up!'))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
