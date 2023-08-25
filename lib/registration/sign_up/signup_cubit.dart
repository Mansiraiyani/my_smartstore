import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/registration/sign_up/signup_repository.dart';
import 'package:my_smartstore/registration/sign_up/signup_state.dart';

class SignUpCubit extends Cubit<SignUpState>{
  SignUpCubit():super(SignUpInitial());
  final SignUpRepository _repository = SignUpRepository();
  void requestotp(email,phone){

try {
  emit(SignUpSubmitting());
  _repository.requestotp(email, phone);
  emit(SignUpSuccess());
}
    catch(value){
  // print(value);
      DioException error = value as DioException;
      if(error.response != null) {
        emit(SignUpFailed(error.response!.data));
      }else {
        if (error.type == DioExceptionType) {
          emit(SignUpFailed("please check your internet connection"));
        }else {
          emit(SignUpFailed(error.message!));//error
        }
      }
     }
  }

}