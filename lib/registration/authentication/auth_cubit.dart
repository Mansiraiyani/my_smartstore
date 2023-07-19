import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_smartstore/registration/authentication/auth_repository.dart';
import 'package:my_smartstore/registration/authentication/auth_state.dart';

class AuthCubit extends Cubit<Authstate>{

  static String token = '';
  AuthRepository authRepository;

  final FlutterSecureStorage storage;

  AuthCubit({required this.storage,required this.authRepository}):super(AuthInitial());

  Future<Authstate> authenticate() async{
    Authstate newstate;
    if(token.isEmpty){
      try{
        var tokenvalue = await _getToken();
        if(tokenvalue == null){
          newstate = LoggedOut();
          emit(newstate);
        }else{
          token=tokenvalue;
          newstate=await _fetchUserData();
        }
      }catch(e){
        newstate = LoggedOut();
        emit(newstate);
      }
    }else{
      newstate = await _fetchUserData();
    }
    return newstate;
  }

  Future<Authstate> _fetchUserData() async{
    Authstate newstate;
    try{
      var response = await authRepository.getUserDate(token: token);
      newstate=Authenticated();
      emit(newstate);
    }catch(value){
      DioException error = value as DioException;
      if(error.response != null){
        newstate = await removeToken();
      }else{
        if(error.type == DioExceptionType.unknown){
          newstate=AuthenticationFailed("please check your internet connection !");
          emit(newstate);
        }else{
          newstate = AuthenticationFailed(error.message!); //error
          emit(newstate);
        }
      }
    }
    return newstate;
  }

  void loggedIn(String tokenvlaue){
    emit(Authenticating());
    token = tokenvlaue;
    _setToken(token).
    then((value) => _fetchUserData());
  }

  Future<Authstate> removeToken()async{
    Authstate newstate;
    token = '';
    try{
      await _deleteToken();
    }catch(e){
      //Nothing
    }newstate = LoggedOut();
    emit(newstate);
    return newstate;
  }

  Future<void> _setToken(token) async{
    await storage.write(key: "token", value: token);
  }

  Future<String?> _getToken()async{
    String? value = await storage.read(key: "token");
    return value;
  }

  Future<void> _deleteToken()async{
    await storage.delete(key: "token");

  }


}

