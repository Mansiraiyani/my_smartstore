import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/registration/otp/otp_state.dart';

import 'otp_repository.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  OtpRepository otpRepository = OtpRepository();
  void verifyotp(
      {required String phone,
      required String otp,
      required String email,
      required String password,
      required String name}) {
    emit(OtpVerifying());
     otpRepository.verifyotp(phone, otp).then((response) {
      _createAccount(email, phone, name, password);

      
    }).catchError((value) {
      DioException error = value;
      if (error.response != null) {
        emit(OtpVerificationFailed(error.response!.data));
      } else {
        if (error.type == DioExceptionType) {
          emit(OtpVerificationFailed("please check your internet connection"));
        } else {
          emit(OtpVerificationFailed(error.message!)); //error
        }
      }
    });
  }

  void _createAccount(email, phone, name, password) {
    otpRepository
        .createAccount(
            email: email, name: name, password: password, phone: phone)
        .then((response) {
      emit(OtpVerified(response.data));
    }).catchError((value) {
      DioException error = value;
      if (error.response != null) {
        emit(OtpVerificationFailed(error.response!.data));
      } else {
        if (error.type == DioExceptionType) {
          emit(OtpVerificationFailed("please check your internet connection"));
        } else {
          emit(OtpVerificationFailed(error.message!)); //error
        }
      }
    });
  }

  void resendOtp({required String phone}) {
    otpRepository.resendOtp(phone);
  }
}
