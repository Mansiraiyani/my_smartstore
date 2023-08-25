import 'package:dio/dio.dart';

import '../../constants.dart';

class OtpRepository {
  final Dio dio = Dio();
  Future<Response> verifyOtp(phone, otp) async {
    print(phone + otp);
    final response = await dio.post("$BASE_URL/verify_otp/", data: {
      'otp': otp,
      'phone': phone,
    });
    print("verify  ${response}");
    return response;
  }

  Future<Response> createAccount({
    required String email,
    required String name,
    required String password,
    required String phone,
  }) async {
    final response = await dio.post("$BASE_URL/create_account/", data: {
      'phone': phone,
      'email': email,
      'password': password,
      'fullname': name,
    });
    return response;
  }

  void resendOtp(phone) {
    dio.post("$BASE_URL/resend_otp/", data: {
      'phone': phone,
    });
  }
}
