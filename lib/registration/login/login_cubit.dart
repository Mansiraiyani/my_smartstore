import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/constants.dart';
import 'package:my_smartstore/registration/login/login_repository.dart';
import 'package:my_smartstore/registration/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  LoginRepository _repository = LoginRepository();
  void login(email_phone, password) {
    String? email, phone;
    emit(LoginSubmitting());
    if (RegExp(EMAIL_REGEX).hasMatch(email_phone)) {
      email = email_phone;

    } else {
      phone = email_phone;

    }
    _repository.login(email, phone, password).then((response) {
      emit(LoginSuccess(response.data));

    }).catchError((value) {
      DioException error = value;
      if (error.response != null) {
        try {
          emit(LoginFailed(error.response!.data));
        } catch (e) {
          emit(LoginFailed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioExceptionType) {
          emit(LoginFailed("please check your internet connection"));
        }

        else {
          print("FAiled");
          emit(LoginFailed(error.message!)); //error
        }
      }
    });
  }
}
