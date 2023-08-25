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
import 'home/fragments/home_fragment/home_fragment_cubit.dart';
import 'home/home_screen.dart';

final AuthRepository authRepository = AuthRepository();
final storage = FlutterSecureStorage();
final AuthCubit authCubit =
    AuthCubit(storage: storage, authRepository: authRepository);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (authCubit.state is AuthInitial) {
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
      create: (context) => authCubit,
      child: BlocBuilder<AuthCubit, Authstate>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: PRIMARY_SWATCH,
            ),
            home: state is Authenticated
                    ? MultiBlocProvider(providers: [
                      BlocProvider(create: (_) => HomeFragmentCubit())
                ],child:HomeScreen()
                )
                : state is AuthenticationFailed || state is Authenticating
                    ? AuthenticatingScreen()
                    : BlocProvider<SignUpCubit>(
                        create: (_) => SignUpCubit(), child: SignUpScreen()),
          );
        },
      ),
    );
  }
}
