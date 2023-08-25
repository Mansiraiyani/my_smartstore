import 'package:dio/dio.dart';

import '../../constants.dart';

class SignUpRepository {
  final Dio dio = Dio();
  Future<dynamic> requestotp(email, phone) async {
    print(email);
    print("phone${phone}");

    var response =
        await dio.post("$BASE_URL/request_otp/", data: {
      'phone': phone,
      'email': email,
    });
    print("=====> ${response}");
    return response;

    // final response = await dio.post(BASE_URL+"/request_otp/",data: {'email':email,
    //   'phone':phone,});
    // print(response);
    // return response;
  }
}
