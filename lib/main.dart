import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_smartstore/constants.dart';
import 'package:my_smartstore/registration/authentication/auth_cubit.dart';
import 'package:my_smartstore/registration/authentication/auth_repository.dart';
import 'package:my_smartstore/registration/authentication/auth_state.dart';
import 'package:my_smartstore/registration/authentication/authenticating_screen.dart';
import 'package:my_smartstore/registration/sign_up/sign_up_screen.dart';
import 'package:my_smartstore/registration/sign_up/signup_cubit.dart';

import 'home/home_screen.dart';

final AuthRepository authRepository = AuthRepository();
final storage = FlutterSecureStorage();
final AuthCubit authCubit = AuthCubit(storage: storage, authRepository: authRepository);

void main() async {
  if(authCubit.state is AuthInitial){
    await authCubit.authenticate();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>authCubit,
      child: BlocBuilder<AuthCubit,Authstate>(
      builder: (context,state){
        return MaterialApp(title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            primarySwatch: PRIMARY_SWATCH,
          ),

          home: state is Authenticated?HomeScreen():state is AuthenticationFailed || state is
        Authenticating?AuthenticatingScreen():BlocProvider<SignUpCubit>
        (create:(_)=>SignUpCubit(),child:SignUpScreen()
          ),
        ); },

      ),
    );
  }
}
